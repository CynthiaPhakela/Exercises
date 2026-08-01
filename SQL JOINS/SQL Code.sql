
-- SQL Joins Exercise-- 

-- Creating All 5 Tables--

--Users--

CREATE OR REPLACE TABLE users (
  user_id INT,
  user_name STRING,
  country STRING
);
 
INSERT INTO users VALUES
  (1, 'Nomvula', 'Johannesburg'),
  (2, 'David', 'Cape Town'),
  (3, 'Anele', 'Durban'),
  (4, 'Kabelo', 'Pretoria'),
  (5, 'Lerato', 'Port Elizabeth');

  --Check table details
  SELECT *
  FROM users
  --------------------------------

-- Plans--

CREATE OR REPLACE TABLE plans (
  plan_id INT,
  plan_name STRING,
  monthly_price DECIMAL(10,2)
);
 
INSERT INTO plans VALUES
  (10, 'Basic', 79),
  (11, 'Standard', 129),
  (12, 'Premium', 199),
  (13, 'Family', 249),
  (14, 'Mobile', 59);

  --Check table details
  SELECT *
  FROM plans
  -------------------

-- Subscriptions

CREATE OR REPLACE TABLE subscriptions (
  subscription_id INT,
  user_id INT,
  plan_id INT,
  start_date DATE
);
 
INSERT INTO subscriptions VALUES
  (501, 1, 10, DATE'2026-01-15'),
  (502, 2, 11, DATE'2026-02-01'),
  (503, 1, 12, DATE'2026-03-10'),
  (504, 6, 11, DATE'2026-03-20'),
  (505, 3, 13, DATE'2026-04-05');

  --Check table details
  SELECT *
  FROM subscriptions
  --------------------------------

-- Shows-- 
CREATE OR REPLACE TABLE shows (
  show_id INT,
  show_title STRING,
  genre STRING
);
 
INSERT INTO shows VALUES
  (701, 'Comedy Hour', 'Comedy'),
  (702, 'Crime Time', 'Drama'),
  (703, 'Tech Tales', 'Documentary'),
  (704, 'Cooking Lab', 'Lifestyle'),
  (706, 'Wild Earth', 'Documentary');

  --Check table details
  SELECT *
  FROM shows
  -------------------------------------

-- Viewing_sessions

CREATE OR REPLACE TABLE viewing_sessions (
  session_id INT,
  user_id INT,
  show_id INT,
  watch_minutes INT
);
 
INSERT INTO viewing_sessions VALUES
  (901, 1, 701, 45),
  (902, 2, 703, 30),
  (903, 1, 702, 60),
  (904, 7, 701, 20),
  (905, 3, 705, 90);

--Check table details
  SELECT *
  FROM viewing_sessions
  --------------------------------------
-- Part A — INNER JOIN (Questions 01–05)
----------------------------------------

--Question 1 — Users with a subscription

SELECT u.user_id, u.user_name, s.subscription_id, s.start_date
FROM users u
INNER JOIN subscriptions s ON u.user_id = s.user_id;
----------------------------------------------------

-- Question 2 — Subscriptions with plan name & price

SELECT s.subscription_id, s.user_id, p.plan_name, p.monthly_price
FROM subscriptions s
INNER JOIN plans p ON s.plan_id = p.plan_id;
---------------------------------------------

-- Question 3 — Viewing sessions with show title & genre

SELECT vs.session_id, vs.user_id, sh.show_title, sh.genre, vs.watch_minutes
FROM viewing_sessions vs
INNER JOIN shows sh ON vs.show_id = sh.show_id;
-----------------------------------------------

-- Question 4 — Viewing sessions with the user who watched

SELECT u.user_name, u.country, vs.session_id, vs.show_id, vs.watch_minutes
FROM users u
INNER JOIN viewing_sessions vs ON u.user_id = vs.user_id;
---------------------------------------------------------

-- Question 5 — Users with subscription & plan (both must match)

SELECT u.user_name, u.country, p.plan_name, p.monthly_price, s.start_date
FROM users u
INNER JOIN subscriptions s ON u.user_id = s.user_id
INNER JOIN plans p ON s.plan_id = p.plan_id;
--------------------------------------------
-- Part B — LEFT JOIN (Questions 06–10)
--------------------------------------------
-- Question 6 — Every user with subscriptions

SELECT u.user_id, u.user_name, s.subscription_id, s.start_date
FROM users u
LEFT JOIN subscriptions s ON u.user_id = s.user_id;
---------------------------------------------------

-- Question 7 — Every plan with its subscriptions

SELECT p.plan_id, p.plan_name, s.subscription_id, s.user_id
FROM plans p
LEFT JOIN subscriptions s ON p.plan_id = s.plan_id;
---------------------------------------------------

-- Question 8 — Every show, with any viewing sessions

SELECT sh.show_id, sh.show_title, vs.session_id, vs.watch_minutes
FROM shows sh
LEFT JOIN viewing_sessions vs ON sh.show_id = vs.show_id;
-----------------------------------------------------------

-- Question 9 — Every viewing session, with the user 
SELECT vs.session_id, vs.show_id, vs.watch_minutes, u.user_id, u.user_name
FROM viewing_sessions vs
LEFT JOIN users u ON vs.user_id = u.user_id;
---------------------------------------------

-- Question 10 — Every user, with their plan 

SELECT u.user_name, u.country, p.plan_name, p.monthly_price
FROM users u
LEFT JOIN subscriptions s ON u.user_id = s.user_id
LEFT JOIN plans p ON s.plan_id = p.plan_id;
---------------------------------------------------------------------

--Part C — FULL OUTER JOIN (Questions 11–15)
----------------------------------------------------------------------
-- Question 11 — Every user AND every subscription

SELECT u.user_id, u.user_name, s.subscription_id, s.start_date
FROM users u
FULL OUTER JOIN subscriptions s ON u.user_id = s.user_id;
---------------------------------------------------------

-- Question 12 — Every plan AND every subscription

SELECT p.plan_id, p.plan_name, s.subscription_id, s.user_id
FROM plans p
FULL OUTER JOIN subscriptions s ON p.plan_id = s.plan_id;
---------------------------------------------------------

-- Question 13 — Every show AND every viewing session

SELECT sh.show_id, sh.show_title, vs.session_id, vs.watch_minutes
FROM shows sh
FULL OUTER JOIN viewing_sessions vs ON sh.show_id = vs.show_id;
-----------------------------------------------------------------------

-- Question 14 — Every user AND every viewing session

SELECT u.user_id, u.user_name, vs.session_id, vs.show_id, vs.watch_minutes
FROM users u
FULL OUTER JOIN viewing_sessions vs ON u.user_id = vs.user_id;
-----------------------------------------------------------------

-- Question 15 — Every user, every subscription, every plan (FULL OUTER JOIN)

SELECT u.user_id, u.user_name, s.subscription_id, p.plan_id, p.plan_name
FROM users u
FULL OUTER JOIN subscriptions s ON u.user_id = s.user_id
FULL OUTER JOIN plans p ON s.plan_id = p.plan_id;
----------------------------------------------------------

-- Bonus Challenge -- 
--------------------------------------------------------------
-- Bonus 01 — Which users have not subscribed to any plan?
-- Answer: users 4 (Kabelo) and 5 (Lerato) — neither appears in the subscriptions table.

SELECT u.user_id, u.user_name
FROM users u
LEFT JOIN subscriptions s ON u.user_id = s.user_id
WHERE s.subscription_id IS NULL;
--------------------------------

-- Bonus 02 — Which subscriptions reference users that do not exist?
-- Answer: Subscription 504, which references user_id 6. There is no user 6 in the users table.

SELECT s.subscription_id, s.user_id, s.plan_id, s.start_date
FROM subscriptions s
LEFT JOIN users u ON s.user_id = u.user_id
WHERE u.user_id IS NULL;
------------------------

-- Bonus 03 — Which shows have never been watched?
-- Answer: show 704 (Cooking Lab) and show 706 (Wild Earth) — neither appears in viewing_sessions.

SELECT sh.show_id, sh.show_title, sh.genre
FROM shows sh
LEFT JOIN viewing_sessions vs ON sh.show_id = vs.show_id
WHERE vs.session_id IS NULL;
----------------------------

-- Bonus 04 — Which viewing sessions reference shows that do not exist?
-- Answer: session 905, which references show_id 705 — there is no show 705 in the shows table.

SELECT vs.session_id, vs.user_id, vs.show_id, vs.watch_minutes
FROM viewing_sessions vs
LEFT JOIN shows sh ON vs.show_id = sh.show_id
WHERE sh.show_id IS NULL;
-------------------------

-- Bonus 05 — Which plans have no subscribers?
-- Answer: plan 14 (Mobile) — no subscription in the subscriptions table references plan_id 14.

SELECT p.plan_id, p.plan_name, p.monthly_price
FROM plans p
LEFT JOIN subscriptions s ON p.plan_id = s.plan_id
WHERE s.subscription_id IS NULL;
