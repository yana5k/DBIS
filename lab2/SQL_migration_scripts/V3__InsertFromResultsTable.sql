insert into "Regions"(regionname)
select distinct 
	case
		when regname is NULL then 'Немає інформаціїї'
		else regname
	end from results
	on conflict do nothing;

insert into "Areas"(areaname,regionname)
select distinct
	case
		when areaname is NULL then 'Немає інформаціїї'
		else areaname
	end,
	regname
	from results
on conflict do nothing;

commit;

insert into "TerritoriesType"(name)
select distinct 
	case
		when tertypename is NULL then 'Немає інформаціїї'
		else tertypename
	end from results
on conflict do nothing;

commit;

insert into "Territories"(name,tertype,areaname)
select distinct
	case
		when tername is NULL then 'Немає інформаціїї'
		else tername
	end,
	tertypename,
	areaname from results
on conflict do nothing;

commit;
---------------------------------------------------------------------
INSERT INTO "School" (name, territory, category, parent)
select distinct
	case
		when eoname is NULL then 'Київський політехнічний інститут'
		else eoname
	end,
	tername,
	eotypename,
	eoparent from results
	union all
	select distinct
	case
		when ukrptname is NULL then 'Київський політехнічний інститут'
		else ukrptname
	end,
	ukrpttername,
	'Немає інформаціїї',
	'Немає інформаціїї' from results
	union all
	select distinct
	case
		when histptname is NULL then 'Київський політехнічний інститут'
		else histptname
	end,
	histpttername,
	'Немає інформаціїї',
	'Немає інформаціїї' from results
	union all
	select distinct
	case
		when mathptname is NULL then 'Київський політехнічний інститут'
		else mathptname
	end,
	mathpttername,
	'Немає інформаціїї',
	'Немає інформаціїї' from results
	union all
	select distinct
	case
		when physptname is NULL then 'Київський політехнічний інститут'
		else physptname
	end,
	physpttername,
	'Немає інформаціїї',
	'Немає інформаціїї' from results
	union all
	select distinct
	case
		when chemptname is NULL then 'Київський політехнічний інститут'
		else chemptname
	end,
	chempttername ,
	'Немає інформаціїї',
	'Немає інформаціїї' from results
	union all
	select distinct
	case
		when bioptname is NULL then 'Київський політехнічний інститут'
		else bioptname
	end,
	biopttername ,
	'Немає інформаціїї',
	'Немає інформаціїї' from results
	union all
	select distinct
	case
		when geoptname is NULL then 'Київський політехнічний інститут'
		else geoptname
	end,
	geopttername ,
	'Немає інформаціїї',
	'Немає інформаціїї' from results
	union all
	select distinct
	case
		when engptname is NULL then 'Київський політехнічний інститут'
		else engptname
	end,
	engpttername ,
	'Немає інформаціїї',
	'Немає інформаціїї' from results
	union all
	select distinct
	case
		when fraptname is NULL then 'Київський політехнічний інститут'
		else fraptname
	end,
	frapttername ,
	'Немає інформаціїї',
	'Немає інформаціїї' from results
	union all
	select distinct
	case
		when deuptname is NULL then 'Київський політехнічний інститут'
		else deuptname
	end,
	deupttername ,
	'Немає інформаціїї',
	'Немає інформаціїї' from results
	union all
	select distinct
	case
		when spaptname is NULL then 'Київський політехнічний інститут'
		else spaptname
	end,
	spapttername ,
	'Немає інформаціїї',
	'Немає інформаціїї' from results
	on conflict do nothing;
----------------------------------------------------------------------
commit;

insert into "RegistrationType"(name)
select distinct 
	case
		when regtypename is NULL then 'Немає інформаціїї'
		else regtypename
	end from results
on conflict do nothing;

commit;

insert into "ClassProfile"(profilename)
select distinct 
	case
		when classprofilename is NULL then 'Немає інформаціїї'
		else classprofilename
	end from results
on conflict do nothing;

commit;

insert into "ClassLanguage"(langname)
select distinct
	case
		when classlangname is NULL then 'Немає інформаціїї'
		else classlangname
	end from results
on conflict do nothing;

commit;

insert into "Genders"(name)
select distinct
	case
		when sextypename is NULL then 'Немає інформаціїї'
		else sextypename
	end from results
on conflict do nothing;

commit;

INSERT INTO "Student" (outid, birthday, gender, territory, profilename, classlangname, school, registrationtype) 
select distinct 
	outid,
	birth,
	sextypename,
	tername,
	classprofilename,
	classlangname,
	eoname,
	regtypename	from results
	on conflict do nothing;
	
commit;
----------------------------------------------------------------------

INSERT INTO "TestSubject"(subject)
values
('Українська мова і література')
,('Історія України')
,('Математика')
,('Фізика')
,('Хімія')
,('Географія')
,('Французька мова')
,('Німецька мова')
,('Іспанська мова')
,('Біологія')
,('Англійська мова')
on conflict do nothing;

commit;

insert into "TestYear"(testingyear) 
select distinct
	case
		when year is NULL then 0
		else year
	end from results
on conflict do nothing;

commit;

insert into "TestStatus"(name) 
select distinct
	case
		when mathteststatus is NULL then 'Немає інформаціїї'
		else mathteststatus
	end from results
on conflict do nothing;

commit;

insert into "TestDPA"(name) 
select distinct
	case
		when engdpalevel is NULL then 'Немає інформаціїї'
		else engdpalevel
	end
	from results

	union all

	select distinct
		case
			when fradpalevel is NULL then 'Немає інформаціїї'
			else fradpalevel
		end
	from results

	union all

	select distinct
		case
			when deudpalevel is NULL then 'Немає інформаціїї'
			else deudpalevel
		end
	from results
	
	union all

	select distinct
		case
			when spadpalevel is NULL then 'Немає інформаціїї'
			else spadpalevel
		end
	from results
	on conflict do nothing;

commit;

insert into "TestLanguage"(langname) 
select distinct
	case
		when histlang is NULL then 'Немає інформаціїї'
		else histlang
	end
	from results

	union all

	select distinct
		case
			when mathlang is NULL then 'Немає інформаціїї'
			else mathlang
		end
	from results

	union all

	select distinct
		case
			when physlang is NULL then 'Немає інформаціїї'
			else physlang
		end
	from results
	on conflict do nothing;

commit;

INSERT INTO "ZnoTest" (studentid, subject, testingyear,  teststatus, ball_100, ball_12, ball_test, adaptscale, school) 
select 
	outid, 
	ukrtest,
	year, 
	ukrteststatus, 
	ukrball100, 
	ukrball12, 
	ukrball, 
	cast(ukradaptscale as numeric), 
	ukrptname from results where ukrtest is not null
	on conflict do nothing;

commit;

INSERT INTO "ZnoTest" (studentid, subject, testingyear, testlanguage, teststatus, ball_100, ball_12, ball_test, school) 
select 
	outid, 
	histtest, 
	year,
	histlang, 
	histteststatus, 
	histball100, 
	histball12, 
	histball, 
	histptname from results where histtest is not null
	on conflict do nothing;

commit;
	
INSERT INTO "ZnoTest" (studentid, subject, testingyear, testlanguage, teststatus, ball_100, ball_12, ball_test, school) 
select 
	outid, 
	mathtest, 
	year, 
	mathlang, 
	mathteststatus, 
	mathball100, 
	mathball12, 
	mathball, 
	mathptname from results where mathtest is not null
	on conflict do nothing;

commit;
	
INSERT INTO "ZnoTest" (studentid, subject, testingyear, testlanguage, teststatus, ball_100, ball_12, ball_test, school) 
select 
	outid, 
	phystest, 
	year, 
	physlang, 
	physteststatus, 
	physball100, 
	physball12, 
	physball, 
	physptname from results where phystest is not null
	on conflict do nothing;

commit;
	
INSERT INTO "ZnoTest" (studentid, subject, testingyear, testlanguage, teststatus, ball_100, ball_12, ball_test, school) 
select 
	outid, 
	chemtest, 
	year, 
	chemlang, 
	chemteststatus, 
	chemball100, 
	chemball12, 
	chemball, 
	chemptname from results where chemtest is not null
	on conflict do nothing;

commit;

INSERT INTO "ZnoTest" (studentid, subject, testingyear, testlanguage, teststatus, ball_100, ball_12, ball_test, school) 
select 
	outid, 
	biotest, 
	year, 
	biolang, 
	bioteststatus, 
	bioball100, 
	bioball12, 
	bioball, 
	bioptname from results where biotest is not null
	on conflict do nothing;

commit;

INSERT INTO "ZnoTest" (studentid, subject, testingyear, testlanguage, teststatus, ball_100, ball_12, ball_test, school) 
select 
	outid, 
	geotest, 
	year, 
	geolang, 
	geoteststatus, 
	geoball100, 
	geoball12, 
	geoball, 
	geoptname from results where geotest is not null
	on conflict do nothing;

commit;

INSERT INTO "ZnoTest" (studentid, subject, testingyear, teststatus, ball_100, ball_12, ball_test, testdpa, school) 
select 
	outid, 
	engtest, 
	year,  
	engteststatus, 
	engball100, 
	engball12, 
	engball, 
	engdpalevel, 
	engptname from results where engtest is not null
	on conflict do nothing;

commit;

INSERT INTO "ZnoTest" (studentid, subject, testingyear, teststatus, ball_100, ball_12, ball_test, testdpa, school) 
select 
	outid, 
	fratest, 
	year,  
	frateststatus, 
	fraball100, 
	fraball12, 
	fraball, 
	fradpalevel, 
	fraptname from results where fratest is not null
	on conflict do nothing;

commit;
	
INSERT INTO "ZnoTest" (studentid, subject, testingyear, teststatus, ball_100, ball_12, ball_test, testdpa, school) 
select 
	outid, 
	deutest, 
	year,  
	deuteststatus, 
	deuball100, 
	deuball12, 
	deuball, 
	deudpalevel, 
	deuptname from results where deutest is not null
	on conflict do nothing;

commit;

INSERT INTO "ZnoTest" (studentid, subject, testingyear, teststatus, ball_100, ball_12, ball_test, testdpa, school) 
select 
	outid, 
	spatest, 
	year,  
	spateststatus, 
	spaball100, 
	spaball12, 
	spaball, 
	spadpalevel, 
	spaptname from results where spatest is not null
	on conflict do nothing;

commit;

----------------------------------------------------------------------