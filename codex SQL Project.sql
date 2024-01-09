select * from fact_survey_responses;
select * from dim_respondents ;
select * from dim_cities;
 use codex;
 
select count(*) from fact_survey_responses;

-- Business Questions-- 
-- Q1.Who prefers energy drink more? 
select gender,count(respondent_id) as total_respondent
from dim_respondents
group by gender
order by total_respondent DESC;
 
-- Q2.Which age group prefers energy drinks more?
select age,count(respondent_id) total_respondent from dim_respondents
group by age
order by total_respondent DEsc;

-- Q3.Which type of marketing reaches the most Youth (15-18)?
select* from fact_survey_responses;
select marketing_channels,count(response_id) as total_respondent from fact_survey_responses as fs 
JOIN dim_respondents dr
ON  fs.respondent_id =dr.respondent_id 
where dr.age = '15-18'
group by marketing_channels
order by total_respondent DESC;

-- Q4.What packaging preferences do respondents have for energy drinks?
select packaging_preference, count(respondent_id) as total_respondant 
from fact_survey_responses
group by packaging_preference
order by total_respondant DESC;

-- Q5.What are the preferred ingredients of energy drinks among respondents?
select ingredients_expected,count(response_id) as total_respondent
from fact_survey_responses
group by ingredients_expected
Order by total_respondent DESC;

-- Q6.What are the primary reasons consumers prefer those brands over ours?
select reasons_for_choosing_brands,count(response_id) as respondent from fact_survey_responses
where current_brands !='CODEX'
group by reasons_for_choosing_brands
order by respondent desc;

 -- Q7.Which marketing channel can be used to reach more customers?
 select marketing_channels,count(response_id) as total_respondent
 from fact_survey_responses
 group by marketing_channels
 order by total_respondent DESC;
 
-- Q8.What do people think about our brand?
 select brand_perception,count(response_id) as total_respondant
 from fact_survey_responses
 group by brand_perception
 order by total_respondant DESC;
 
 select heard_before, count(response_id) as total_respondent
 from fact_survey_responses
 group by heard_before
 order by total_respondent DESC;
 
 select taste_experience,count(response_id) as total_respondent
 from fact_survey_responses
 group by taste_experience
 order by total_respondent DESC;
 
 select taste_experience, count(respondent_id) as total_respondent 
from fact_survey_responses 
where tried_before="yes" AND heard_before="yes" 
group by taste_experience 
order by taste_experience DESC; 

 -- Q9.Which cities do we need to focus more on?
  select
  dc.City, 
    dc.Tier, 
    count(dc.City) AS c_Response, 
	round(count(dc.City) * 100.0 / sum(count(dc.City)) OVER (), 2) AS Percentage
from fact_survey_responses fs
JOIN dim_respondents dr ON fs.Respondent_ID = dr.Respondent_ID
JOIN dim_cities dc ON dc.City_ID = dr.City_ID
where fs.Brand_perception = "Negative" or fs.Brand_perception = "Neutral" and Current_brands = 'codex'
group by dc.City, dc.Tier
order by c_response DESC;

-- Q10.Who are the current market leaders?
select count(response_id) as response,current_brands from fact_survey_responses
group by current_brands
order by response desc;

 -- Q11.Where do respondents prefer to purchase energy drinks?
  select purchase_location,count(response_id) as t_respondent
  from fact_survey_responses
  group by purchase_location
  order by t_respondent DESC;
  
 -- Q12.What are the typical consumption situations for energy drinks among respondents?

  select typical_consumption_situations, count(response_id) t_respondent
  from fact_survey_responses
  group by typical_consumption_situations
  order by t_respondent DESC;
  
-- Q13.What factors influence respondents' purchase decisions, 
-- such as price range and limited edition packaging?
  
  select Limited_edition_packaging, count(response_id) t_respondent
  from fact_survey_responses
  group by Limited_edition_packaging
  order by t_respondent DESC;
  
  select price_range,count(response_id) as t_respondant
  from fact_survey_responses
  group by price_range
  order by t_respondant desc;
  
-- Q14.Which area of business should we focus more on our product development? (Branding/taste/availability).
  
  select reasons_for_choosing_brands, count(response_id) as respondent 
from fact_survey_responses
where current_brands = "Codex"
group by reasons_for_choosing_brands
order by respondent DESC;
  
  -- Q15.Reasons why customer love Codex Energy Drink.
select consume_reason, round(count(response_ID),2) AS respondent 
from fact_survey_responses
group by Consume_reason
order by respondent DESC;
 
