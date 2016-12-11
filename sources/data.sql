-- inserts

-- Roles
exec AddRole('admin', 2);
exec AddRole('user', 1);

-- Users (admin with hash for salt)
exec AddUser('admin', 'md5$12345$20a65baf9d17296b2237c9ff6928140c', 'admin');


-- Heroes
-- strength
exec AddHero ('Earthshaker');
exec AddHero ('Sven');
exec AddHero ('Tiny');
exec AddHero ('Axe');
exec AddHero ('Pudge');
exec AddHero ('Sand King');
exec AddHero ('Kunkka');
exec AddHero ('Slardar');
exec AddHero ('Beastmaster');
exec AddHero ('Tidehunter');
exec AddHero ('Dragon Knight');
exec AddHero ('Wraith King');
exec AddHero ('Clockwerk');
exec AddHero ('Lifestealer');
exec AddHero ('Omniknight');
exec AddHero ('Night Stalker');
exec AddHero ('Huskar');
exec AddHero ('Doom');
exec AddHero ('Alchemist');
exec AddHero ('Spirit Breaker');
exec AddHero ('Brewmaster');
exec AddHero ('Lycan');
exec AddHero ('Treant Protector');
exec AddHero ('Chaos Knight');
exec AddHero ('Io');
exec AddHero ('Undying');
exec AddHero ('Centaur Warrunner');
exec AddHero ('Timbersaw');
exec AddHero ('Abaddon');
exec AddHero ('Bristleback');
exec AddHero ('Tusk');
exec AddHero ('Elder Titan');
exec AddHero ('Legion Commander');
exec AddHero ('Earth Spirit');
exec AddHero ('Phoenix');
exec AddHero ('Magnus');

-- agility
exec AddHero ('Anti-Mage');
exec AddHero ('Bloodseeker');
exec AddHero ('Drow Ranger');
exec AddHero ('Shadow Fiend');
exec AddHero ('Juggernaut');
exec AddHero ('Razor');
exec AddHero ('Mirana');
exec AddHero ('Venomancer');
exec AddHero ('Morphling');
exec AddHero ('Faceless Void');
exec AddHero ('Phantom Lancer');
exec AddHero ('Phantom Assassin');
exec AddHero ('Vengeful Spirit');
exec AddHero ('Viper');
exec AddHero ('Riki');
exec AddHero ('Clinkz');
exec AddHero ('Sniper');
exec AddHero ('Broodmother');
exec AddHero ('Templar Assassin');
exec AddHero ('Weaver');
exec AddHero ('Luna');
exec AddHero ('Spectre');
exec AddHero ('Bounty Hunter');
exec AddHero ('Nyx Assassin');
exec AddHero ('Ursa');
exec AddHero ('Meepo');
exec AddHero ('Gyrocopter');
exec AddHero ('Slark');
exec AddHero ('Lone Druid');
exec AddHero ('Medusa');
exec AddHero ('Naga Siren');
exec AddHero ('Terrorblade');
exec AddHero ('Troll Warlord');
exec AddHero ('Arc Warden');
exec AddHero ('Ember Spirit');

-- intelligence
exec AddHero ('Crystal Maiden');
exec AddHero ('Bane');
exec AddHero ('Puck');
exec AddHero ('Lich');
exec AddHero ('Storm Spirit');
exec AddHero ('Lion');
exec AddHero ('Windranger');
exec AddHero ('Witch Doctor');
exec AddHero ('Zeus');
exec AddHero ('Enigma');
exec AddHero ('Lina');
exec AddHero ('Necrophos');
exec AddHero ('Shadow Shaman');
exec AddHero ('Warlock');
exec AddHero ('Tinker');
exec AddHero ('Queen of Pain');
exec AddHero ('Nature''s Prophet');
exec AddHero ('Death Prophet');
exec AddHero ('Enchantress');
exec AddHero ('Pugna');
exec AddHero ('Jakiro');
exec AddHero ('Dazzle');
exec AddHero ('Chen');
exec AddHero ('Leshrac');
exec AddHero ('Silencer');
exec AddHero ('Dark Seer');
exec AddHero ('Ogre Magi');
exec AddHero ('Batrider');
exec AddHero ('Rubick');
exec AddHero ('Ancient Apparation');
exec AddHero ('Disruptor');
exec AddHero ('Invoker');
exec AddHero ('Keeper of the Light');
exec AddHero ('Outworld Devourer');
exec AddHero ('Skywrath Mage');
exec AddHero ('Shadow Demon');
exec AddHero ('Techies');
exec AddHero ('Visage');
exec AddHero ('Oracle');
exec AddHero ('Winter Wyvern');

-- Coaches
exec AddPlayer ('1437', 6, 'Theeban', 'Siva', 'USA');
exec AddPlayer ('71', 6, 'Tang', 'Wenyi', 'China');
exec AddPlayer ('Goblak', 6, 'Artur', 'Kostenko', 'Ukraine');
exec AddPlayer ('Alex', 6, 'Alexander', 'Reinhardt', 'Germany');

-- Players
-- 1. Navi
exec AddPlayer ('Ditya Ra', 1, 'Dmitry', 'Minenkov', 'Russia');
exec AddPlayer ('Dendi', 2, 'Danil', 'Ishutin', 'Ukraine');
exec AddPlayer ('GeneRaL', 3, 'Victor', 'Nigrini', 'Ukraine');
exec AddPlayer ('SoNNeikO', 4, 'Akbar', 'Butaev', 'Russia');
exec AddPlayer ('Artstyle', 5, 'Ivan', 'Antonov', 'Ukraine');

-- 2. Alliance
exec AddPlayer ('Loda', 1, 'Jonathan', 'Berg', 'Sweden');
exec AddPlayer ('s4', 2, 'Gustav', 'Magnusson', 'Sweden');
exec AddPlayer ('AdmiralBulldog', 3, 'Henrik', 'Ahnberg', 'Sweden');
exec AddPlayer ('EGM', 4, 'Jerry', 'Lundkvist', 'Sweden');
exec AddPlayer ('Akke', 5, 'Joakim', 'Akterhall', 'Sweden');

-- 3. OG
exec AddPlayer ('Miracle-', 1, 'Amer', 'Barqawi', 'Jordan');
exec AddPlayer ('N0tail', 2, 'Johan', 'Sundstein', 'Denmark');
exec AddPlayer ('MoonMeander', 3, 'David', 'Tan', 'Canada');
exec AddPlayer ('Cr1t-', 4, 'Andreas', 'Nielsen', 'Denmark');
exec AddPlayer ('Fly', 5, 'Tal', 'Aizik', 'Israel');

-- 4. Virtus.pro
exec AddPlayer ('yoky-', 1, 'Maxim', 'Kim', 'Russia');
exec AddPlayer ('G', 2, 'Sergey', 'Bragin', 'Russia');
exec AddPlayer ('fng', 3, 'Artem', 'Barshak', 'Belarus');
exec AddPlayer ('ALOHADANCE', 4, 'Ilya', 'Korobkin', 'Ukraine');
exec AddPlayer ('NoFear', 5, 'Alexander', 'Churochkin', 'Russia');

-- 5. Vega Squadron
exec AddPlayer ('fn', 1, 'Rostislav', 'Lozovoi', 'Ukraine');
exec AddPlayer ('No[o]ne', 2, 'Vladimir', 'Minenko', 'Ukraine');
exec AddPlayer ('Mag~', 3, 'Andrey', 'Chipenko', 'Ukraine');
exec AddPlayer ('Solo', 4, 'Alexei', 'Berezin', 'Russia');
exec AddPlayer ('CemaTheSlayeR', 5, 'Semion', 'Krivulya', 'Ukraine');

-- 6. Team Liquid
exec AddPlayer ('MATUMBAMAN', 1, 'Lasse', 'Urpalainen', 'Finland');
exec AddPlayer ('FATA-', 2, 'Adrian', 'Trinks', 'Germany');
exec AddPlayer ('Mind_ContRol', 3, 'Ivan', 'Borislavov', 'Bulgaria');
exec AddPlayer ('JerAx', 4, 'Jesse', 'Vainikka', 'Finland');
exec AddPlayer ('KuroKy', 5, 'Kuro', 'Takhasomi', 'Germany');

-- 7. Evil Geniuses
exec AddPlayer ('Aui_2000', 1, 'Kurtis', 'Ling', 'USA');
exec AddPlayer ('SumaiL', 2, 'Sumail', 'Hassan', 'USA');
exec AddPlayer ('BuLba', 3, 'Kanishka', 'Sosale', 'USA');
exec AddPlayer ('Fear', 4, 'Clinton', 'Loomis', 'USA');
exec AddPlayer ('ppd', 5, 'Peter', 'Dager', 'USA');

-- 8. Digital Chaos
exec AddPlayer ('Resolut1on', 1, 'Roman', 'Fominok', 'Ukraine');
exec AddPlayer ('w33', 2, 'Aliwi', 'Omar', 'Romania');
exec AddPlayer ('Moo', 3, 'David', 'Hull', 'USA');
exec AddPlayer ('Saksa', 4, 'Martin', 'Sazdov', 'Macedonia');
exec AddPlayer ('MiSeRy', 5, 'Rasmus', 'Filipsen', 'Denmark');

-- 9. Team Secret
exec AddPlayer ('EternalEnVy', 1, 'Jacky', 'Mao', 'Canada');
exec AddPlayer ('Arteezy', 2, 'Artour', 'Babaev', 'Canada');
exec AddPlayer ('UNiVeRsE', 3, 'Saahil', 'Arora', 'USA');
exec AddPlayer ('Puppey', 4, 'Clement', 'Ivanov', 'Estonia');
exec AddPlayer ('pieliedie', 5, 'Johan', 'Astrom', 'Sweden');

-- 10. MVP Phoenix
exec AddPlayer ('MP', 1, 'Pyo', 'No-a', 'South Korea');
exec AddPlayer ('QO', 2, 'Kim', 'Seon-yeob', 'South Korea');
exec AddPlayer ('FoREV', 3, 'Lee', 'Sang-don', 'South Korea');
exec AddPlayer ('Febby', 4, 'Kim', 'Yong-min', 'South Korea');
exec AddPlayer ('DuBu', 5, 'Kim', 'Doo-young', 'South Korea');

-- 11. LGD Gaming
exec AddPlayer ('Agressif', 1, 'Sun', 'Zheng', 'China');
exec AddPlayer ('Maybe', 2, 'Lu', 'Yao', 'China');
exec AddPlayer ('xiao8', 3, 'Xue', 'Zhichuan', 'China');
exec AddPlayer ('September', 4, 'Zhang', 'Ning', 'China');
exec AddPlayer ('MMY!', 5, 'Lei', 'Zengrong', 'China');

-- 12. Fnatic
exec AddPlayer ('Mushi', 1, 'Chai', 'Fung', 'Malaysia');
exec AddPlayer ('Miduan', 2, 'Yeik', 'Nai', 'Malaysia');
exec AddPlayer ('Ohaiyo', 3, 'Chong', 'Khoo', 'Malaysia');
exec AddPlayer ('DJ', 4, 'Djardel', 'Mampusti', 'Philippines');
exec AddPlayer ('Net', 5, 'Wai', 'Lim', 'Malaysia');

-- 13. Vici Gaming
exec AddPlayer ('BurNIng', 1, 'Xu', 'Zhilei', 'China');
exec AddPlayer ('Cty', 2, 'Chen', 'Tianyu', 'China');
exec AddPlayer ('rOtK', 3, 'Bai', 'Fan', 'China');
exec AddPlayer ('Hym', 4, 'Xu', 'Zhi', 'China');
exec AddPlayer ('Sylar', 5, 'Liu', 'Jiajun', 'China');

-- 14. Newbee
exec AddPlayer ('Hao', 1, 'Chen', 'Zhiahao', 'China');
exec AddPlayer ('Mu', 2, 'Zhang', 'Pan', 'China');
exec AddPlayer ('kpii', 3, 'Damien', 'Chok', 'Australia');
exec AddPlayer ('Kaka', 4, 'Hu', 'Liangzhi', 'China');
exec AddPlayer ('ChuaN', 5, 'Wong', 'Chuan', 'Malaysia');

-- 15. EHOME.cn
exec AddPlayer ('LaNm', 1, 'Zhang', 'Zhicheng', 'China');
exec AddPlayer ('old chicken', 2, 'Wang', 'Zhiyong', 'China');
exec AddPlayer ('eLeVeN', 3, 'Ren', 'Yangwei', 'China');
exec AddPlayer ('iceiceice', 4, 'Daryl', 'Xiang', 'Singapore');
exec AddPlayer ('Fenrir', 5, 'Lu', 'Chao', 'China');

-- 16. compLexity Gaming
exec AddPlayer ('Chessie', 1, 'Rasmus', 'Blomdin', 'Sweden');
exec AddPlayer ('Limmp', 2, 'Linus', 'Blomdin', 'Sweden');
exec AddPlayer ('swindlemelonzz', 3, 'Kyle', 'Freedman', 'USA');
exec AddPlayer ('Zfreek', 4, 'Zakari', 'Freedman', 'USA');
exec AddPlayer ('Handsken', 5, 'Simon', 'Haag', 'Sweden');

-- 17. CDEC Gaming
exec AddPlayer ('Rabbit', 1, 'Wang', 'Zhang', 'China');
exec AddPlayer ('Super', 2, 'Xie ', 'Junhao', 'China');
exec AddPlayer ('Yao', 3, 'Yao', 'Zhengzheng', 'China');
exec AddPlayer ('Q', 4, 'Fu', 'Bin', 'China');
exec AddPlayer ('garder', 5, 'Lu', 'Xinzhou', 'China');

-- Teams
exec AddTeam ('Natus Vincere', 'Artstyle', 'Ukraine', 'Goblak');
exec AddTeam ('Alliance', 's4', 'Sweden');
exec AddTeam ('OG', 'Fly', 'Europe');
exec AddTeam ('Virtus.pro', 'fng', 'Russia');
exec AddTeam ('Vega Squadron', 'CemaTheSlayeR', 'Russia');
exec AddTeam ('Team Liquid', 'KuroKy', 'Netherlands', 'Alex');
exec AddTeam ('Evil Geniuses', 'ppd', 'USA');
exec AddTeam ('Digital Chaos', 'MiSeRy', 'USA');
exec AddTeam ('Team Secret', 'Puppey', 'Europe', '1437');
exec AddTeam ('MVP Phoenix', 'DuBu', 'South Korea');
exec AddTeam ('LGD Gaming', 'xiao8', 'China');
exec AddTeam ('Fnatic', 'Mushi', 'Europe');
exec AddTeam ('Vici Gaming', 'rOtK', 'China');
exec AddTeam ('Newbee', 'Hao', 'China');
exec AddTeam ('EHOME.cn', 'LaNm', 'China', '71');
exec AddTeam ('compLexity Gaming', 'swindlemelonzz', 'USA');
exec AddTeam ('CDEC Gaming', 'Q', 'China');


-- Sponsors
exec AddSponsor ('Dailymotion');
exec AddSponsor ('Tesoro');
exec AddSponsor ('Dota 2 Lounge');
exec AddSponsor ('HyperX');
exec AddSponsor ('MLG');
exec AddSponsor ('Valve');
exec AddSponsor ('DotaCinema');

-- Tournaments
exec AddTournament ('The Shanghai Major 2016', '16 teams, winner/loser bracket', 'offline', 3000000, '2016-02-25', '2016-03-06', '6.86f');
exec AddTournament ('MLG World Finals 2015', '8 teams, single-elimination bracket', 'offline', 250000, '2015-10-16', '2015-10-18', '6.86e');
exec AddTournament ('Dota 2 Champions League Season 4', '8 teams, single-elimination bracket', 'online', 76000, '2014-09-01', '2014-11-02', '6.85c');
exec AddTournament ('Captains Draft 3.0', '16 teams, winner/loser bracket', 'online', 100000, '2016-01-19', '2016-02-17', '6.86e');

-- TournamentTeam
exec AddTournamentTeam ('Dota 2 Champions League Season 4', 'Natus Vincere', '1');
exec AddTournamentTeam ('Dota 2 Champions League Season 4', 'Alliance', '1');
exec AddTournamentTeam ('Dota 2 Champions League Season 4', 'Virtus.pro', '1');
exec AddTournamentTeam ('Dota 2 Champions League Season 4', 'Fnatic', '1');

exec AddTournamentTeam ('The Shanghai Major 2016', 'OG', '1');
exec AddTournamentTeam ('The Shanghai Major 2016', 'Evil Geniuses', '1');
exec AddTournamentTeam ('The Shanghai Major 2016', 'Team Secret', '1');
exec AddTournamentTeam ('The Shanghai Major 2016', 'EHOME.cn', '1');
exec AddTournamentTeam ('The Shanghai Major 2016', 'Vici Gaming', '1');
exec AddTournamentTeam ('The Shanghai Major 2016', 'Virtus.pro', '1');
exec AddTournamentTeam ('The Shanghai Major 2016', 'Alliance', '1');
exec AddTournamentTeam ('The Shanghai Major 2016', 'Team Liquid', '0');
exec AddTournamentTeam ('The Shanghai Major 2016', 'LGD Gaming', '0');
exec AddTournamentTeam ('The Shanghai Major 2016', 'Newbee', '0');
exec AddTournamentTeam ('The Shanghai Major 2016', 'MVP Phoenix', '0');
exec AddTournamentTeam ('The Shanghai Major 2016', 'Fnatic', '0');
exec AddTournamentTeam ('The Shanghai Major 2016', 'CDEC Gaming', '1');

exec AddTournamentTeam ('Captains Draft 3.0', 'Evil Geniuses', '1');
exec AddTournamentTeam ('Captains Draft 3.0', 'Vega Squadron', '1');
exec AddTournamentTeam ('Captains Draft 3.0', 'Virtus.pro', '1');
exec AddTournamentTeam ('Captains Draft 3.0', 'Team Liquid', '1');
exec AddTournamentTeam ('Captains Draft 3.0', 'Alliance', '1');
exec AddTournamentTeam ('Captains Draft 3.0', 'Digital Chaos', '0');

exec AddTournamentTeam ('MLG World Finals 2015', 'MVP Phoenix', '1');
exec AddTournamentTeam ('MLG World Finals 2015', 'Team Secret', '1');
exec AddTournamentTeam ('MLG World Finals 2015', 'LGD Gaming', '1');
exec AddTournamentTeam ('MLG World Finals 2015', 'Evil Geniuses', '1');
exec AddTournamentTeam ('MLG World Finals 2015', 'OG', '0');

-- TournamentWinners
exec AddTournamentWinner ('Natus Vincere', 'Dota 2 Champions League Season 4', '2014-11-02', 1, 38118);
exec AddTournamentWinner ('Virtus.pro', 'Dota 2 Champions League Season 4', '2014-11-02', 2, 19059);
exec AddTournamentWinner ('Fnatic', 'Dota 2 Champions League Season 4', '2014-11-01', 3, 11435);
exec AddTournamentWinner ('Team Secret', 'The Shanghai Major 2016', '2016-03-06', 1, 1110000);
exec AddTournamentWinner ('Team Liquid', 'The Shanghai Major 2016', '2016-03-06', 2, 405000);
exec AddTournamentWinner ('Evil Geniuses', 'The Shanghai Major 2016', '2016-03-06', 3, 315000);
exec AddTournamentWinner ('Evil Geniuses', 'Captains Draft 3.0', '2016-02-17', 1, 43454);
exec AddTournamentWinner ('Vega Squadron', 'Captains Draft 3.0', '2016-02-17', 2, 28555);
exec AddTournamentWinner ('Alliance', 'Captains Draft 3.0', '2016-02-10', 3, 18623);
exec AddTournamentWinner ('Team Secret', 'MLG World Finals 2015', '2015-10-18', 1, 113982);
exec AddTournamentWinner ('Evil Geniuses', 'MLG World Finals 2015', '2015-10-18', 2, 68389);
exec AddTournamentWinner ('OG', 'MLG World Finals 2015', '2015-10-18', 3, 34194);

-- SponsorTournament
exec AddSponsorTournament ('Valve', 'The Shanghai Major 2016');
exec AddSponsorTournament ('Dailymotion', 'Dota 2 Champions League Season 4');
exec AddSponsorTournament ('Tesoro', 'Dota 2 Champions League Season 4');
exec AddSponsorTournament ('Dota 2 Lounge', 'Dota 2 Champions League Season 4');
exec AddSponsorTournament ('HyperX', 'Dota 2 Champions League Season 4');
exec AddSponsorTournament ('DotaCinema', 'Captains Draft 3.0');
exec AddSponsorTournament ('MLG', 'MLG World Finals 2015');


-- Matches
exec AddMatch ('Dota 2 Champions League Season 4', 'Natus Vincere', 'Fnatic', '2014-10-31', 'semi-finals', 2, 0);
exec AddMatch ('Dota 2 Champions League Season 4', 'Virtus.pro', 'Alliance', '2014-10-31', 'semi-finals', 2, 0);
exec AddMatch ('Dota 2 Champions League Season 4', 'Fnatic', 'Alliance', '2014-11-01', 'loser''s round 1', 2, 1);
exec AddMatch ('Dota 2 Champions League Season 4', 'Natus Vincere', 'Virtus.pro', '2014-11-01', 'winner''s finals', 2, 1);
exec AddMatch ('Dota 2 Champions League Season 4', 'Virtus.pro', 'Fnatic', '2014-11-02', 'loser''s finals', 2, 1);
exec AddMatch ('Dota 2 Champions League Season 4', 'Natus Vincere', 'Virtus.pro', '2014-11-02', 'grand finals', 3, 0);

exec AddMatch ('The Shanghai Major 2016', 'MVP Phoenix', 'EHOME.cn', '2016-02-25', 'group stage, group a', 2, 0);
exec AddMatch ('The Shanghai Major 2016', 'Team Secret', 'CDEC Gaming', '2016-02-25', 'group stage, group a', 2, 1);
exec AddMatch ('The Shanghai Major 2016', 'EHOME.cn', 'CDEC Gaming', '2016-02-25', 'group stage, group a', 2, 1);
exec AddMatch ('The Shanghai Major 2016', 'MVP Phoenix', 'Team Secret', '2016-02-25', 'group stage, group a', 2, 0);
exec AddMatch ('The Shanghai Major 2016', 'EHOME.cn', 'Team Secret', '2016-02-25', 'group stage, group a', 0, 2);

exec AddMatch ('Captains Draft 3.0', 'Team Liquid', 'Vega Squadron', '2016-02-05', 'group stage, group hippo', 0, 2);
exec AddMatch ('Captains Draft 3.0', 'Evil Geniuses', 'Vega Squadron', '2016-02-06', 'group stage, group hippo', 2, 1);
exec AddMatch ('Captains Draft 3.0', 'Team Liquid', 'Evil Geniuses', '2016-02-07', 'group stage, group hippo', 1, 2);
exec AddMatch ('Captains Draft 3.0', 'Alliance', 'Digital Chaos', '2016-02-08', 'group stage, group horse', 2, 0);
exec AddMatch ('Captains Draft 3.0', 'Virtus.pro', 'Digital Chaos', '2016-02-09', 'group stage, group horse', 2, 0);
exec AddMatch ('Captains Draft 3.0', 'Alliance', 'Virtus.pro', '2016-02-10', 'group stage, group horse', 2, 0);

exec AddMatch ('MLG World Finals 2015', 'Evil Geniuses', 'OG', '2015-10-16', 'group stage, group a', 1, 2);
exec AddMatch ('MLG World Finals 2015', 'LGD Gaming', 'Virtus.pro', '2015-10-16', 'group stage, group a', 0, 2);
exec AddMatch ('MLG World Finals 2015', 'Virtus.pro', 'OG', '2015-10-16', 'group stage, group a', 0, 2);
exec AddMatch ('MLG World Finals 2015', 'LGD Gaming', 'Evil Geniuses', '2015-10-16', 'group stage, group a', 1, 2);
exec AddMatch ('MLG World Finals 2015', 'Virtus.pro', 'Evil Geniuses', '2015-10-17', 'group stage, group a', 1, 2);
exec AddMatch ('MLG World Finals 2015', 'Team Secret', 'MVP Phoenix', '2015-10-16', 'group stage, group b', 2, 0);


-- TeamPlayer
exec AddTeamPlayer ('Natus Vincere', 'Dendi', '2015-10-20');
exec AddTeamPlayer ('Natus Vincere', 'Ditya Ra', '2015-12-07');
exec AddTeamPlayer ('Natus Vincere', 'GeneRaL', '2016-02-23');
exec AddTeamPlayer ('Natus Vincere', 'SoNNeikO', '2015-10-20');
exec AddTeamPlayer ('Natus Vincere', 'Artstyle', '2015-12-08');
exec AddTeamPlayer ('Natus Vincere', 'Goblak', '2015-12-08');

exec AddTeamPlayer ('Alliance', 'Loda', '2013-04-12');
exec AddTeamPlayer ('Alliance', 's4', '2015-08-27');
exec AddTeamPlayer ('Alliance', 'AdmiralBulldog', '2013-04-12');
exec AddTeamPlayer ('Alliance', 'EGM', '2015-12-07');
exec AddTeamPlayer ('Alliance', 'Akke', '2013-04-12');

exec AddTeamPlayer ('OG', 'Miracle-', '2015-10-31');
exec AddTeamPlayer ('OG', 'N0tail', '2015-10-31');
exec AddTeamPlayer ('OG', 'MoonMeander', '2015-10-31');
exec AddTeamPlayer ('OG', 'Cr1t-', '2015-10-31');
exec AddTeamPlayer ('OG', 'Fly', '2015-10-31');

exec AddTeamPlayer ('Virtus.pro', 'yoky-', '2016-03-25');
exec AddTeamPlayer ('Virtus.pro', 'G', '2015-04-15');
exec AddTeamPlayer ('Virtus.pro', 'fng', '2015-04-15');
exec AddTeamPlayer ('Virtus.pro', 'ALOHADANCE', '2016-03-25');
exec AddTeamPlayer ('Virtus.pro', 'NoFear', '2016-03-25');

exec AddTeamPlayer ('Vega Squadron', 'fn', '2016-03-22');
exec AddTeamPlayer ('Vega Squadron', 'No[o]ne', '2014-11-20');
exec AddTeamPlayer ('Vega Squadron', 'Mag~', '2015-04-25');
exec AddTeamPlayer ('Vega Squadron', 'Solo', '2015-04-25');
exec AddTeamPlayer ('Vega Squadron', 'CemaTheSlayeR', '2014-11-20');

exec AddTeamPlayer ('Team Liquid', 'MATUMBAMAN', '2015-10-09');
exec AddTeamPlayer ('Team Liquid', 'FATA-', '2015-10-09');
exec AddTeamPlayer ('Team Liquid', 'Mind_ContRol', '2015-10-09');
exec AddTeamPlayer ('Team Liquid', 'JerAx', '2015-10-09');
exec AddTeamPlayer ('Team Liquid', 'KuroKy', '2015-10-09');
exec AddTeamPlayer ('Team Liquid', 'Alex', '2015-10-09');

exec AddTeamPlayer ('Evil Geniuses', 'Aui_2000', '2016-03-25');
exec AddTeamPlayer ('Evil Geniuses', 'SumaiL', '2015-01-05');
exec AddTeamPlayer ('Evil Geniuses', 'BuLba', '2016-03-25');
exec AddTeamPlayer ('Evil Geniuses', 'Fear', '2011-10-24');
exec AddTeamPlayer ('Evil Geniuses', 'ppd', '2014-02-21');

exec AddTeamPlayer ('Digital Chaos', 'Resolut1on', '2016-02-04');
exec AddTeamPlayer ('Digital Chaos', 'w33', '2016-03-26');
exec AddTeamPlayer ('Digital Chaos', 'Moo', '2016-03-26');
exec AddTeamPlayer ('Digital Chaos', 'Saksa', '2016-03-26');
exec AddTeamPlayer ('Digital Chaos', 'MiSeRy', '2016-03-26');

exec AddTeamPlayer ('Team Secret', 'EternalEnVy', '2015-08-22');
exec AddTeamPlayer ('Team Secret', 'Arteezy', '2016-03-22');
exec AddTeamPlayer ('Team Secret', 'UNiVeRsE', '2016-03-22');
exec AddTeamPlayer ('Team Secret', 'Puppey', '2014-08-27');
exec AddTeamPlayer ('Team Secret', 'pieliedie', '2015-08-22');
exec AddTeamPlayer ('Team Secret', '1437', '2015-08-22');

exec AddTeamPlayer ('MVP Phoenix', 'MP', '2015-08-26');
exec AddTeamPlayer ('MVP Phoenix', 'QO', '2014-03-04');
exec AddTeamPlayer ('MVP Phoenix', 'FoREV', '2015-12-08');
exec AddTeamPlayer ('MVP Phoenix', 'Febby', '2015-02-06');
exec AddTeamPlayer ('MVP Phoenix', 'DuBu', '2015-12-08');

exec AddTeamPlayer ('LGD Gaming', 'Agressif', '2016-03-18');
exec AddTeamPlayer ('LGD Gaming', 'Maybe', '2015-03-15');
exec AddTeamPlayer ('LGD Gaming', 'xiao8', '2015-03-08');
exec AddTeamPlayer ('LGD Gaming', 'September', '2016-03-18');
exec AddTeamPlayer ('LGD Gaming', 'MMY!', '2014-08-26');

exec AddTeamPlayer ('Fnatic', 'Mushi', '2015-06-04');
exec AddTeamPlayer ('Fnatic', 'Miduan', '2015-12-07');
exec AddTeamPlayer ('Fnatic', 'Ohaiyo', '2015-06-04');
exec AddTeamPlayer ('Fnatic', 'DJ', '2015-08-26');
exec AddTeamPlayer ('Fnatic', 'Net', '2015-08-26');

exec AddTeamPlayer ('Vici Gaming', 'Sylar', '2016-04-08');
exec AddTeamPlayer ('Vici Gaming', 'Cty', '2016-03-20');
exec AddTeamPlayer ('Vici Gaming', 'rOtK', '2016-03-20');
exec AddTeamPlayer ('Vici Gaming', 'BurNIng', '2015-09-03');
exec AddTeamPlayer ('Vici Gaming', 'Hym', '2016-03-20');

exec AddTeamPlayer ('Newbee', 'Hao', '2015-09-03');
exec AddTeamPlayer ('Newbee', 'Mu', '2014-02-23');
exec AddTeamPlayer ('Newbee', 'kpii', '2016-03-25');
exec AddTeamPlayer ('Newbee', 'Kaka', '2016-03-25');
exec AddTeamPlayer ('Newbee', 'ChuaN', '2015-12-07');

exec AddTeamPlayer ('EHOME.cn', 'eLeVeN', '2015-09-01');
exec AddTeamPlayer ('EHOME.cn', 'old chicken', '2015-09-01');
exec AddTeamPlayer ('EHOME.cn', 'iceiceice', '2016-03-08');
exec AddTeamPlayer ('EHOME.cn', 'LaNm', '2015-03-15');
exec AddTeamPlayer ('EHOME.cn', 'Fenrir', '2016-03-08');
exec AddTeamPlayer ('EHOME.cn', '71', '2016-03-08');

exec AddTeamPlayer ('compLexity Gaming', 'Chessie', '2015-11-24');
exec AddTeamPlayer ('compLexity Gaming', 'Limmp', '2015-11-24');
exec AddTeamPlayer ('compLexity Gaming', 'swindlemelonzz', '2014-08-27');
exec AddTeamPlayer ('compLexity Gaming', 'Zfreek', '2014-08-27');
exec AddTeamPlayer ('compLexity Gaming', 'Handsken', '2015-11-24');

exec AddTeamPlayer ('CDEC Gaming', 'Rabbit', '2016-03-20');
exec AddTeamPlayer ('CDEC Gaming', 'Super', '2016-03-20');
exec AddTeamPlayer ('CDEC Gaming', 'Yao', '2016-03-20');
exec AddTeamPlayer ('CDEC Gaming', 'Q', '2014-10-14');
exec AddTeamPlayer ('CDEC Gaming', 'garder', '2014-10-14');


-- SignatureHero
-- 1. Natus Vincere
exec AddSignatureHero ('Ditya Ra', 'Ember Spirit');
exec AddSignatureHero ('Ditya Ra', 'Nature''s Prophet');
exec AddSignatureHero ('Ditya Ra', 'Lycan');

exec AddSignatureHero ('Dendi', 'Pudge');
exec AddSignatureHero ('Dendi', 'Magnus');
exec AddSignatureHero ('Dendi', 'Puck');

exec AddSignatureHero('GeneRaL', 'Shadow Fiend'); 
exec AddSignatureHero('GeneRaL', 'Invoker'); 
exec AddSignatureHero('GeneRaL', 'Batrider'); 

exec AddSignatureHero('SoNNeikO', 'Io');
exec AddSignatureHero('SoNNeikO', 'Earthshaker');
exec AddSignatureHero('SoNNeikO', 'Winter Wyvern');

exec AddSignatureHero('Artstyle', 'Chen');
exec AddSignatureHero('Artstyle', 'Night Stalker');
exec AddSignatureHero('Artstyle', 'Shadow Demon');
-- 2. Alliance
exec AddSignatureHero('Loda', 'Juggernaut');
exec AddSignatureHero('Loda', 'Lifestealer');
exec AddSignatureHero('Loda', 'Gyrocopter');

exec AddSignatureHero('s4', 'Puck');
exec AddSignatureHero('s4', 'Magnus');
exec AddSignatureHero('s4', 'Batrider');

exec AddSignatureHero('AdmiralBulldog', 'Nature''s Prophet');
exec AddSignatureHero('AdmiralBulldog', 'Lone Druid');
exec AddSignatureHero('AdmiralBulldog', 'Broodmother');

exec AddSignatureHero('EGM', 'Io');
exec AddSignatureHero('EGM', 'Rubick');
exec AddSignatureHero('EGM', 'Shadow Demon');

exec AddSignatureHero('Akke', 'Chen');
exec AddSignatureHero('Akke', 'Enchantress');
exec AddSignatureHero('Akke', 'Keeper of the Light');
-- 3. OG
exec AddSignatureHero('Miracle-', 'Shadow Fiend');
exec AddSignatureHero('Miracle-', 'Slark');
exec AddSignatureHero('Miracle-', 'Anti-Mage');

exec AddSignatureHero('N0tail', 'Chen');
exec AddSignatureHero('N0tail', 'Meepo');
exec AddSignatureHero('N0tail', 'Io');

exec AddSignatureHero('MoonMeander', 'Dark Seer');
exec AddSignatureHero('MoonMeander', 'Nature''s Prophet');
exec AddSignatureHero('MoonMeander', 'Earthshaker');

exec AddSignatureHero('Cr1t-', 'Io');
exec AddSignatureHero('Cr1t-', 'Rubick');
exec AddSignatureHero('Cr1t-', 'Bane');

exec AddSignatureHero('Fly', 'Rubick');
exec AddSignatureHero('Fly', 'Dazzle');
exec AddSignatureHero('Fly', 'Undying');
-- 4. Virtus.pro
exec AddSignatureHero('yoky-', 'Tidehunter');
exec AddSignatureHero('yoky-', 'Axe');
exec AddSignatureHero('yoky-', 'Earthshaker');

exec AddSignatureHero('G', 'Queen of Pain');
exec AddSignatureHero('G', 'Shadow Fiend');
exec AddSignatureHero('G', 'Storm Spirit');

exec AddSignatureHero('fng', 'Vengeful Spirit');
exec AddSignatureHero('fng', 'Bane');
exec AddSignatureHero('fng', 'Treant Protector');

exec AddSignatureHero('ALOHADANCE', 'Rubick');
exec AddSignatureHero('ALOHADANCE', 'Io');
exec AddSignatureHero('ALOHADANCE', 'Disruptor');

exec AddSignatureHero('NoFear', 'Earthshaker');
exec AddSignatureHero('NoFear', 'Dazzle');
exec AddSignatureHero('NoFear', 'Vengeful Spirit');
-- 5. Vega Squadron
exec AddSignatureHero('fn', 'Slark');
exec AddSignatureHero('fn', 'Invoker');
exec AddSignatureHero('fn', 'Juggernaut');

exec AddSignatureHero('No[o]ne', 'Shadow Fiend');
exec AddSignatureHero('No[o]ne', 'Storm Spirit');
exec AddSignatureHero('No[o]ne', 'Puck');

exec AddSignatureHero('Mag~', 'Centaur Warrunner');
exec AddSignatureHero('Mag~', 'Broodmother');
exec AddSignatureHero('Mag~', 'Clockwerk');

exec AddSignatureHero('Solo', 'Io');
exec AddSignatureHero('Solo', 'Chen');
exec AddSignatureHero('Solo', 'Rubick');

exec AddSignatureHero('CemaTheSlayeR', 'Dazzle');
exec AddSignatureHero('CemaTheSlayeR', 'Skywrath Mage');
exec AddSignatureHero('CemaTheSlayeR', 'Witch Doctor');
-- 6. Team Liquid
exec AddSignatureHero('MATUMBAMAN', 'Ember Spirit');
exec AddSignatureHero('MATUMBAMAN', 'Juggernaut');
exec AddSignatureHero('MATUMBAMAN', 'Slark');

exec AddSignatureHero('FATA-', 'Puck');
exec AddSignatureHero('FATA-', 'Beastmaster');
exec AddSignatureHero('FATA-', 'Razor');

exec AddSignatureHero('Mind_ContRol', 'Dark Seer');
exec AddSignatureHero('Mind_ContRol', 'Clockwerk');
exec AddSignatureHero('Mind_ContRol', 'Tusk');

exec AddSignatureHero('JerAx', 'Earth Spirit');
exec AddSignatureHero('JerAx', 'Tusk');
exec AddSignatureHero('JerAx', 'Winter Wyvern');

exec AddSignatureHero('KuroKy', 'Rubick');
exec AddSignatureHero('KuroKy', 'Visage');
exec AddSignatureHero('KuroKy', 'Io');
-- 7. Evil Geniuses
exec AddSignatureHero('Fear', 'Enigma');
exec AddSignatureHero('Fear', 'Undying');
exec AddSignatureHero('Fear', 'Beastmaster');

exec AddSignatureHero('SumaiL', 'Storm Spirit');
exec AddSignatureHero('SumaiL', 'Shadow Fiend');
exec AddSignatureHero('SumaiL', 'Ember Spirit');

exec AddSignatureHero('BuLba', 'Clockwerk');
exec AddSignatureHero('BuLba', 'Batrider');
exec AddSignatureHero('BuLba', 'Elder Titan');

exec AddSignatureHero('Aui_2000', 'Visage');
exec AddSignatureHero('Aui_2000', 'Chen');
exec AddSignatureHero('Aui_2000', 'Enigma');

exec AddSignatureHero('ppd', 'Treant Protector');
exec AddSignatureHero('ppd', 'Crystal Maiden');
exec AddSignatureHero('ppd', 'Vengeful Spirit');
-- 8. Digital Chaos
exec AddSignatureHero('w33', 'Meepo');
exec AddSignatureHero('w33', 'Windranger');
exec AddSignatureHero('w33', 'Invoker');

exec AddSignatureHero('Resolut1on', 'Invoker');
exec AddSignatureHero('Resolut1on', 'Puck');
exec AddSignatureHero('Resolut1on', 'Dragon Knight');

exec AddSignatureHero('Moo', 'Tusk');
exec AddSignatureHero('Moo', 'Dark Seer');
exec AddSignatureHero('Moo', 'Slardar');

exec AddSignatureHero('Saksa', 'Tusk');
exec AddSignatureHero('Saksa', 'Lina');
exec AddSignatureHero('Saksa', 'Skywrath Mage');

exec AddSignatureHero('MiSeRy', 'Lion');
exec AddSignatureHero('MiSeRy', 'Slardar');
exec AddSignatureHero('MiSeRy', 'Nyx Assassin');
-- 9. Team Secret
exec AddSignatureHero('EternalEnVy', 'Luna');
exec AddSignatureHero('EternalEnVy', 'Gyrocopter');
exec AddSignatureHero('EternalEnVy', 'Terrorblade');

exec AddSignatureHero('Arteezy', 'Lycan');
exec AddSignatureHero('Arteezy', 'Shadow Fiend');
exec AddSignatureHero('Arteezy', 'Naga Siren');

exec AddSignatureHero('UNiVeRsE', 'Dark Seer');
exec AddSignatureHero('UNiVeRsE', 'Clockwerk');
exec AddSignatureHero('UNiVeRsE', 'Faceless Void');

exec AddSignatureHero('Puppey', 'Chen');
exec AddSignatureHero('Puppey', 'Enchantress');
exec AddSignatureHero('Puppey', 'Enigma');

exec AddSignatureHero('pieliedie', 'Bounty Hunter');
exec AddSignatureHero('pieliedie', 'Lion');
exec AddSignatureHero('pieliedie', 'Bane');
-- 10. MVP Phoenix
exec AddSignatureHero('MP', 'Invoker');
exec AddSignatureHero('MP', 'Storm Spirit');
exec AddSignatureHero('MP', 'Juggernaut');

exec AddSignatureHero('QO', 'Templar Assassin');
exec AddSignatureHero('QO', 'Slark');
exec AddSignatureHero('QO', 'Queen of Pain');

exec AddSignatureHero('FoREV', 'Ember Spirit');
exec AddSignatureHero('FoREV', 'Nature''s Prophet');
exec AddSignatureHero('FoREV', 'Tidehunter');

exec AddSignatureHero('Febby', 'Io');
exec AddSignatureHero('Febby', 'Bounty Hunter');
exec AddSignatureHero('Febby', 'Earthshaker');

exec AddSignatureHero('DuBu', 'Bane');
exec AddSignatureHero('DuBu', 'Witch Doctor');
exec AddSignatureHero('DuBu', 'Earth Spirit');
-- 11. LGD Gaming
exec AddSignatureHero('Agressif', 'Gyrocopter');
exec AddSignatureHero('Agressif', 'Phantom Lancer');
exec AddSignatureHero('Agressif', 'Ember Spirit');

exec AddSignatureHero('Maybe', 'Shadow Fiend');
exec AddSignatureHero('Maybe', 'Storm Spirit');
exec AddSignatureHero('Maybe', 'Dragon Knight');

exec AddSignatureHero('xiao8', 'Doom');
exec AddSignatureHero('xiao8', 'Nature''s Prophet');
exec AddSignatureHero('xiao8', 'Lina');

exec AddSignatureHero('September', 'Phoenix');
exec AddSignatureHero('September', 'Enchantress');
exec AddSignatureHero('September', 'Bounty Hunter');

exec AddSignatureHero('MMY!', 'Rubick');
exec AddSignatureHero('MMY!', 'Lion');
exec AddSignatureHero('MMY!', 'Io');
-- 12. Fnatic
exec AddSignatureHero('Mushi', 'Shadow Fiend');
exec AddSignatureHero('Mushi', 'Queen of Pain');
exec AddSignatureHero('Mushi', 'Outworld Devourer');

exec AddSignatureHero('Miduan', 'Templar Assassin');
exec AddSignatureHero('Miduan', 'Puck');
exec AddSignatureHero('Miduan', 'Invoker');

exec AddSignatureHero('Ohaiyo', 'Nature''s Prophet');
exec AddSignatureHero('Ohaiyo', 'Batrider');
exec AddSignatureHero('Ohaiyo', 'Dark Seer');

exec AddSignatureHero('DJ', 'Chen');
exec AddSignatureHero('DJ', 'Enchantress');
exec AddSignatureHero('DJ', 'Earth Spirit');

exec AddSignatureHero('Net', 'Sand King');
exec AddSignatureHero('Net', 'Rubick');
exec AddSignatureHero('Net', 'Shadow Shaman');
-- 13. Vici Gaming
exec AddSignatureHero('BurNIng', 'Anti-Mage');
exec AddSignatureHero('BurNIng', 'Morphling');
exec AddSignatureHero('BurNIng', 'Luna');

exec AddSignatureHero('Cty', 'Queen of Pain');
exec AddSignatureHero('Cty', 'Storm Spirit');
exec AddSignatureHero('Cty', 'Juggernaut');

exec AddSignatureHero('rOtK', 'Tidehunter');
exec AddSignatureHero('rOtK', 'Dark Seer');
exec AddSignatureHero('rOtK', 'Clockwerk');

-- 14. Newbee
exec AddSignatureHero('Hao', 'Gyrocopter');
exec AddSignatureHero('Hao', 'Morphling');
exec AddSignatureHero('Hao', 'Spectre');

exec AddSignatureHero('Mu', 'Dragon Knight');
exec AddSignatureHero('Mu', 'Templar Assassin');
exec AddSignatureHero('Mu', 'Brewmaster');

exec AddSignatureHero('kpii', 'Naga Siren');
exec AddSignatureHero('kpii', 'Invoker');
exec AddSignatureHero('kpii', 'Gyrocopter');

exec AddSignatureHero('Kaka', 'Io');
exec AddSignatureHero('Kaka', 'Vengeful Spirit');
exec AddSignatureHero('Kaka', 'Rubick');

exec AddSignatureHero('ChuaN', 'Rubick');
exec AddSignatureHero('ChuaN', 'Enchantress');
exec AddSignatureHero('ChuaN', 'Lion');
-- 15. EHOME.cn
exec AddSignatureHero('LaNm', 'Lion');
exec AddSignatureHero('LaNm', 'Rubick');
exec AddSignatureHero('LaNm', 'Earthshaker');

exec AddSignatureHero('old chicken', 'Dragon Knight');
exec AddSignatureHero('old chicken', 'Viper');
exec AddSignatureHero('old chicken', 'Brewmaster');

exec AddSignatureHero('eLeVeN', 'Tusk');
exec AddSignatureHero('eLeVeN', 'Tidehunter');
exec AddSignatureHero('eLeVeN', 'Clockwerk');

exec AddSignatureHero('iceiceice', 'Tidehunter');
exec AddSignatureHero('iceiceice', 'Timbersaw');
exec AddSignatureHero('iceiceice', 'Invoker');

exec AddSignatureHero('Fenrir', 'Visage');
exec AddSignatureHero('Fenrir', 'Skywrath Mage');
exec AddSignatureHero('Fenrir', 'Shadow Demon');
-- 16. compLexity Gaming
exec AddSignatureHero('Chessie', 'Invoker');
exec AddSignatureHero('Chessie', 'Magnus');
exec AddSignatureHero('Chessie', 'Morphling');

exec AddSignatureHero('Limmp', 'Morphling');
exec AddSignatureHero('Limmp', 'Lina');
exec AddSignatureHero('Limmp', 'Queen of Pain');

exec AddSignatureHero('swindlemelonzz', 'Viper');
exec AddSignatureHero('swindlemelonzz', 'Dragon Knight');
exec AddSignatureHero('swindlemelonzz', 'Slardar');

exec AddSignatureHero('Zfreek', 'Chen');
exec AddSignatureHero('Zfreek', 'Enigma');
exec AddSignatureHero('Zfreek', 'Io');

exec AddSignatureHero('Handsken', 'Disruptor');
exec AddSignatureHero('Handsken', 'Io');
exec AddSignatureHero('Handsken', 'Chen');
-- 17. CDEC Gaming
exec AddSignatureHero('Rabbit', 'Lifestealer');
exec AddSignatureHero('Rabbit', 'Gyrocopter');
exec AddSignatureHero('Rabbit', 'Weaver');

exec AddSignatureHero('Super', 'Dragon Knight');
exec AddSignatureHero('Super', 'Alchemist');
exec AddSignatureHero('Super', 'Shadow Fiend');

exec AddSignatureHero('Yao', 'Invoker');
exec AddSignatureHero('Yao', 'Clockwerk');
exec AddSignatureHero('Yao', 'Ember Spirit');

exec AddSignatureHero('Q', 'Visage');
exec AddSignatureHero('Q', 'Ancient Apparation');
exec AddSignatureHero('Q', 'Skywrath Mage');

exec AddSignatureHero('garder', 'Lion');
exec AddSignatureHero('garder', 'Bounty Hunter');
exec AddSignatureHero('garder', 'Earthshaker');
-- 18. Coaches
exec AddSignatureHero('1437', 'Dazzle');
exec AddSignatureHero('1437', 'Shadow Demon');
exec AddSignatureHero('1437', 'Visage');

exec AddSignatureHero('Goblak', 'Chen');
exec AddSignatureHero('Goblak', 'Treant Protector');
exec AddSignatureHero('Goblak', 'Bane');
