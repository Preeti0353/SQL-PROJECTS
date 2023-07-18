USE OPEARATION_ANALYTICS;
---1.Calculate the weekly user engagement?*
SELECT 
  DATEPART(WEEK, occurred_at) AS week_number,
  COUNT(DISTINCT user_id) AS number_of_users
FROM
  events
GROUP BY
  DATEPART(WEEK, occurred_at)
ORDER BY
  week_number;
  
----2. Calculate the user growth for product*
WITH cte AS (
  SELECT 
    DATEPART(YEAR, activated_at) AS year_num,
    DATEPART(WEEK, activated_at) AS week_num,
    COUNT(DISTINCT user_id) AS num_active_users
  FROM 
    USERS
  WHERE 
    state = 'active'
  GROUP BY 
    DATEPART(YEAR, activated_at), DATEPART(WEEK, activated_at)
)
SELECT 
  year_num,
  week_num,
  num_active_users,
  SUM(num_active_users) OVER (ORDER BY year_num, week_num ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cum_active_users
FROM 
  cte
ORDER BY 
  year_num, week_num;

select count(*) from USERS
where state = 'active';

  --3. Calculate the weekly engagement per device*
  -- Without specifying the week number
SELECT
  user_id,
  COUNT(user_id),
  SUM(CASE WHEN retention_week = 1 THEN 1 ELSE 0 END) AS per_week_retention
FROM 
(
  SELECT
    a.user_id,
    a.signup_week,
    b.engagement_week,
    b.engagement_week - a.signup_week AS retention_week
  FROM 
  (
    SELECT
      DISTINCT user_id,
      DATEPART(WEEK, occurred_at) AS signup_week
    FROM
      EVENTS
    WHERE
      event_type = 'signup_flow'
      AND event_name = 'complete_signup'
  ) a 
  LEFT JOIN
  (
    SELECT
      DISTINCT user_id,
      DATEPART(WEEK, occurred_at) AS engagement_week
    FROM
      EVENTS
    WHERE
      event_type = 'engagement'
  ) b 
  ON a.user_id = b.user_id
) d 
GROUP BY
  user_id
ORDER BY
  user_id;

-- Specifying the week number as 18
SELECT
  user_id,
  COUNT(user_id),
  SUM(CASE WHEN retention_week = 1 THEN 1 ELSE 0 END) AS per_week_retention
FROM 
(
  SELECT
    a.user_id,
    a.signup_week,
    b.engagement_week,
    b.engagement_week - a.signup_week AS retention_week
  FROM 
  (
    SELECT
      DISTINCT user_id,
      DATEPART(WEEK, occurred_at) AS signup_week
    FROM
      EVENTS
    WHERE
      event_type = 'signup_flow'
      AND event_name = 'complete_signup'
      AND DATEPART(WEEK, occurred_at) = 18
  ) a 
  LEFT JOIN
  (
    SELECT
      DISTINCT user_id,
      DATEPART(WEEK, occurred_at) AS engagement_week
    FROM
      EVENTS
    WHERE
      event_type = 'engagement'
  ) b 
  ON a.user_id = b.user_id
) d 
GROUP BY
  user_id
ORDER BY
  user_id;


--4.Calculate the weekly engagement per device
SELECT 
  DATEPART(YEAR, occurred_at) AS year_num,
  DATEPART(WEEK, occurred_at) AS week_num,
  device,
  COUNT(DISTINCT user_id) AS no_of_users
FROM 
  EVENTS
WHERE 
  event_type = 'engagement'
GROUP BY 
  DATEPART(YEAR, occurred_at),
  DATEPART(WEEK, occurred_at),
  device
ORDER BY 
  DATEPART(YEAR, occurred_at),
  DATEPART(WEEK, occurred_at),
  device;

--5. Calculate the email engagement metrics
SELECT
  100.0 * SUM(CASE WHEN email_cat = 'email_opened' THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN email_cat = 'email_sent' THEN 1 ELSE 0 END), 0) AS email_opening_rate,
  100.0 * SUM(CASE WHEN email_cat = 'email_clicked' THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN email_cat = 'email_sent' THEN 1 ELSE 0 END), 0) AS email_clicking_rate
FROM 
(
  SELECT 
    *,
    CASE 
      WHEN action IN ('sent_weekly_digest', 'sent_reengagement_email') THEN 'email_sent'
      WHEN action = 'email_open' THEN 'email_opened'
      WHEN action = 'email_clickthrough' THEN 'email_clicked'
    END AS email_cat
  FROM EMAIL
) a;
