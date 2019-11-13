
-- https://fivethirtyeight.datasettes.com/fivethirtyeight
-- Where general unemployment rate is higher on average than graduate school 
select
    *
from
  [college-majors/all-ages] as aa
  join [college-majors/grad-students] as ga on aa.Major_code = ga.Major_code
  where aa.Unemployment_rate >  ga.Grad_unemployment_rate


-- Where college Unemployment is higher in general
select 
    *
from
  [college-majors/all-ages] as aa
  join [college-majors/grad-students] as ga on aa.Major_code = ga.Major_code
  where  ga.Grad_unemployment_rate > aa.Unemployment_rate 
  group by Unemployed 
  order by Unemployed desc 


-- General Employment across a major_category 
-- insight lowest 60% in Library Science vs 80% in public policy and computer science
-- https://fivethirtyeight.datasettes.com/fivethirtyeight?sql=select%0D%0A++++aa.Major%2C+sum%28aa.employed%29*1.0+%2F+sum%28aa.total%29+as+employment_rate%0D%0Afrom%0D%0A++%5Bcollege-majors%2Fall-ages%5D+as+aa%0D%0A++group+by+aa.major_category%0D%0A++order+by+employment_rate%0D%0A
select
    aa.Major, sum(aa.employed)*1.0 / sum(aa.total) as employment_rate
from
  [college-majors/all-ages] as aa
  group by aa.major_category
  order by employment_rate
