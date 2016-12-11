declare
    cursor c1 is
        select table_name
        from user_tables;
begin
    for t in c1 loop
        execute immediate ('drop table ' || t.table_name || ' cascade constraints');
    end loop;
end;
/

create table Roles (
    id integer constraint pk_roles primary key,
    name varchar2(40) not null unique,
    priority integer not null
);
create table Users (
    id integer constraint pk_users primary key,
    roleId integer constraint fk_users_roles references Roles(id),
    login varchar2(64) not null unique,
    password varchar2(64) not null  
);

create table Heroes (
    id integer constraint pk_heroes primary key,
    name varchar2(45) not null unique
);
create table Players (
    id integer constraint pk_players primary key,
    nickName varchar2(30) not null unique,
    position integer not null,
    firstName varchar2(20) not null,
    lastName varchar2(20) not null,
    country varchar2(20) not null
); 
create table Teams (
    id integer constraint pk_teams primary key,
    captainId not null constraint fk_teams_captain references Players(id),
    coachId constraint fk_teams_coach references Players(id),
    name varchar2(30) not null unique,
    location varchar2(30) not null
);
create table Tournaments (
    id integer constraint pk_tournaments primary key,
    name varchar2(70) not null unique,
    type varchar2(20) not null,
    format varchar2(200) not null,
    prizePool integer not null,
    startDate timestamp not null,
    endDate timestamp not null,
    gameVersion varchar2(10) not null
);
create table Matches (
    id integer constraint pk_matches primary key,
    tournamentId integer not null constraint fk_matches_tournament references Tournaments(id),
    firstTeamId not null constraint fk_matches_teams_1 references Teams(id),
    secondTeamId not null constraint fk_matches_teams_2 references Teams(id),
    matchDate timestamp not null,
    bracketStage varchar2(40) not null,
    firstTeamScore integer not null,
    secondTeamScore integer not null
);
create table Sponsors (
    id integer constraint pk_sponsors primary key,
    url varchar2(100) not null
);
create table TournamentWinners (
    id integer constraint pk_tournamentWinners primary key,
    teamId not null constraint fk_tournamentWinners_teams references Teams(id),
    tournamentId not null constraint fk_tournWinners_tourns references Tournaments(id),
    winDate timestamp not null,
    place integer not null,
    usd integer not null
);
create table SignatureHeroes (
    playerId not null constraint fk_signHeroes_players references Players(id),
    heroId not null constraint fk_signHeroes_heroes references Heroes(id),
    constraint pk_signatureHeroes primary key (playerId, heroId)
);
create table SponsorsTournaments (
    sponsorId not null constraint fk_sponssTourns_sponss references Sponsors(id),
    tournamentId not null constraint fk_sponssTourns_tourns references Tournaments(id),
    constraint pk_sponsorsTournaments primary key (sponsorId, tournamentId)
);
create table TeamsPlayers (
    teamId not null constraint fk_teamsPlayers_teams references Teams(id),
    playerId not null constraint fk_teamsPlayers_players references Players(id),
    joinDate timestamp not null,
    leaveDate timestamp not null,
    constraint pk_teamsPlayers primary key(teamId, playerId)
);
create table TournamentsTeams (
    tournamentId not null constraint fk_tournsTeams_tourns references Tournaments(id),
    teamId not null constraint fk_tournsTeams_teams references Teams(id),
    isInvited char(1) not null,
    constraint pk_tournamentsTeams primary key(teamId, tournamentId) 
);