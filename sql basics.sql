use heroes;
select*from hero_battles
order by num_enemies;

select*from hero_battles
order by num_enemies desc;

select*from hero_battles
where name = "batman"
order by num_enemies desc;

select*from hero_battles
where not name = "batman"
order by num_enemies;

select*from hero_battles where num_enemies in (1,2);

select*from hero_battles where num_enemies in (1,2,10,12);

select*from hero_battles
where name like "%man%";