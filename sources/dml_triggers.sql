create or replace trigger tr_role_del
    before delete on Roles
    for each row
begin
    delete from Users
    where roleId = :old.id;
end;
/

create or replace trigger tr_heroes_del
    before delete on Heroes
    for each row
begin
    delete from SignatureHeroes
    where heroId = :old.id;
end;
/

create or replace trigger tr_player_del
    before delete on Players
    for each row
begin
    delete from TeamsPlayers 
    where playerId = :old.id;
    delete from SignatureHeroes
    where playerId = :old.id;
end;
/ 


create or replace trigger tr_team_del
    before delete on Teams
    for each row
begin
    delete from Matches 
    where firstTeamId = :old.id or 
          secondTeamId = :old.id;
    delete from TeamsPlayers 
    where teamId = :old.id;
    delete from TournamentsTeams 
    where teamId = :old.id;
    delete from TournamentWinners 
    where teamId = :old.id;
end;
/ 
    
create or replace trigger tr_tournament_del
    before delete on Tournaments
    for each row
begin
    delete from Matches where tournamentId = :old.id;
    delete from TournamentWinners where tournamentId = :old.id;
    delete from TournamentsTeams where tournamentId = :old.id;
    delete from SponsorsTournaments where tournamentId = :old.id;
end;
/

create or replace trigger tr_sponsors_del
    before delete on Sponsors
    for each row
begin
    delete from SponsorsTournaments
    where sponsorId = :old.id;
end;
/