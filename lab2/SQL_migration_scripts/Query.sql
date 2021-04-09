select res2019.region  as "Region",
        res2019.score as "English 2019",
        res2020.score as "English 2020"
    from (select resArea.region as region,
		avg(resStudent.engAvg) as score
	from (select "Student".territory Sterritory,
				  "ZnoTest".ball_100 engAvg
				  from "Student" inner join "ZnoTest" on "Student".outid = "ZnoTest".studentid	
			where "ZnoTest".teststatus = 'Зараховано' 
			and "ZnoTest".subject='Англійська мова'
			and "ZnoTest".testingyear = 2019) as resStudent
		inner join
			(select "Territories".name Tterritory,"Areas".regionname region from "Territories" inner join "Areas" on "Territories".areaname = "Areas".areaname) as resArea
		on resStudent.Sterritory = resArea.Tterritory
		group by resArea.region) as res2019
            join
        (select resArea.region as region,
		avg(resStudent.engAvg) as score
	from (select "Student".territory Sterritory,
				  "ZnoTest".ball_100 engAvg
				  from "Student" inner join "ZnoTest" on "Student".outid = "ZnoTest".studentid	
			where "ZnoTest".teststatus = 'Зараховано' 
			and "ZnoTest".subject='Англійська мова'
			and "ZnoTest".testingyear = 2020) as resStudent
		inner join
			(select "Territories".name Tterritory,"Areas".regionname region from "Territories" inner join "Areas" on "Territories".areaname = "Areas".areaname) as resArea
		on resStudent.Sterritory = resArea.Tterritory
		group by resArea.region) as res2020
        on res2019.region = res2020.region
    order by res2019.region;