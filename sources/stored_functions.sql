create or replace function RightAccess(p_UserLogin in varchar2, p_RoleNameNeed in varchar2) return integer
is
    l_UserRolePriority integer;
    l_NeedRolePriority integer;
    
begin
    if (p_UserLogin is null) then
        return 0;
    end if;

    select Roles.priority into l_UserRolePriority
    from Roles,
         Users
    where Users.login = p_UserLogin and
          Roles.id = Users.roleId;

    select priority into l_NeedRolePriority
    from Roles
    where name = p_RoleNameNeed;

    if (l_UserRolePriority < l_NeedRolePriority) then
        return 0;
    else 
        return 1;
    end if;
end;
/


create or replace function AuthorizeUser(p_UserLogin in varchar2, p_UserPassword in varchar2) return integer
is
    l_Result integer;
begin
    select count(id) into l_Result
    from Users
    where login = p_UserLogin and
          password = p_UserPassword;

    return l_Result;
end;
/


-- HELPER

create or replace function NullSysRefCursor return sys_refcursor
is
    o_RC1 sys_refcursor;
begin
    open o_RC1 for
        select * 
        from Dual
        where 1 = 2;

    return o_RC1;
end;
/

-- TEAM PAGE

create or replace function TeamShortInfo(p_TeamId in integer) return sys_refcursor
is
    l_Winrate varchar2(8);
    o_RC1 sys_refcursor;
begin
    select to_char(sum(Wins) / sum(Loses) * 100.0, '99.99') || '%' into l_Winrate
    from (
            (select sum(firstTeamScore) as Wins 
             from Matches
             where firstTeamId = 1 and 
                firstTeamScore > secondTeamScore)
             union all
            (select sum(secondTeamScore) as Wins 
             from Matches
             where secondTeamId = 1 and 
                secondTeamScore > firstTeamScore)),
            (select sum(firstTeamScore + secondTeamScore) as Loses
             from Matches
             where firstTeamId = p_TeamId or
                secondTeamId = p_TeamId);

    open o_RC1 for 
        select  Teams.name, 
                Teams.location, 
                (select l_Winrate
                 from Dual),
                 Teams.captainId,
                (select Players.firstName || ' ''' || Players.nickName || ''' ' || Players.lastName
                 as CaptainName
                 from Players
                 where Players.id = Teams.captainId),
                 (select Players.firstName || ' ''' || Players.nickName || ''' ' || Players.lastName
                 as CoachName
                 from Players
                 where Players.id = Teams.coachId)
        from Teams,
             Players
        where Teams.id = p_TeamId and 
              rownum = 1;

    return o_RC1;
end;
/

create or replace function TeamCurrentRoster(p_TeamId in integer) return sys_refcursor
is
    o_RC1 sys_refcursor;
begin
    open o_RC1 for 
        select Players.id,
               Players.Country, 
               Players.NickName, 
               Players.firstName || ' ' || Players.lastName, 
               Players.position, 
               to_char(TeamsPlayers.joinDate, 'yyyy-mm-dd') 
        from TeamsPlayers,
             Players
        where TeamsPlayers.teamId = p_TeamId and
              Players.id = TeamsPlayers.playerId and
              TeamsPlayers.leaveDate = to_date('9999-12-01', 'yyyy-mm-dd');

    return o_RC1;
end;
/

create or replace function TeamFormerPlayers(p_TeamId in integer) return sys_refcursor
is
    o_RC1 sys_refcursor;
begin
    open o_RC1 for
        select Players.id,
               Players.country, 
               Players.nickName, 
               Players.firstName || ' ' || Players.lastName, 
               Players.position, 
               to_char(TeamsPlayers.joinDate, 'yyyy-mm-dd'), 
               to_char(TeamsPlayers.leaveDate, 'yyyy-mm-dd') 
        from TeamsPlayers,
             Players
        where TeamsPlayers.teamId = p_TeamId and
              Players.id = TeamsPlayers.playerId and 
              TeamsPlayers.leaveDate != to_date('9999-12-01', 'yyyy-mm-dd');
              
    return o_RC1;
end;
/


create or replace function TeamAchievements(p_TeamId in integer) return sys_refcursor
is
    o_RC1 sys_refcursor;
begin
    open o_RC1 for 
        select Tournaments.id,
               to_char(TournamentWinners.winDate, 'yyyy-mm-dd'), 
               TournamentWinners.place, 
               Tournaments.name, 
               TournamentWinners.usd
        from TournamentWinners, 
             Tournaments
        where TournamentWinners.teamId = p_TeamId and 
              Tournaments.id = TournamentWinners.tournamentId;
    
    return o_RC1;
end;
/

-- PLAYER PAGE

create or replace function PlayerShortInfo(p_PlayerId in integer) return sys_refcursor
is
    o_RC1 sys_refcursor;
begin
    open o_RC1 for 
        select Players.nickName,
               Players.firstName || ' ' || Players.lastName, 
               Players.country, 
               Teams.name, 
               Players.position
        from Teams,
             Players,
             TeamsPlayers
        where TeamsPlayers.playerId = p_PlayerId and
              Teams.id = TeamsPlayers.teamId and
              TeamsPlayers.leaveDate = to_date('9999-12-01', 'yyyy-mm-dd') and
              Players.id = p_PlayerId and
              rownum = 1;

    return o_RC1;
end;
/

create or replace function PlayerPreviousTeams(p_PlayerId in integer) return sys_refcursor
is
    o_RC1 sys_refcursor;
begin
    open o_RC1 for 
    select Teams.id,
           to_char(TeamsPlayers.joinDate, 'yyyy-mm-dd'), 
           to_char(TeamsPlayers.leaveDate, 'yyyy-mm-dd'), 
           Teams.name 
    from TeamsPlayers,
         Teams
    where TeamsPlayers.playerId = p_PlayerId and 
          TeamsPlayers.leaveDate is not null and
          Teams.id = TeamsPlayers.teamId and
          TeamsPlayers.leaveDate != to_date('9999-12-01', 'yyyy-mm-dd');

    return O_RC1;
end;
/

create or replace function PlayerSignatureHeroes(p_PlayerId in integer) return sys_refcursor
is
    o_RC1 sys_refcursor;
begin
    open o_RC1 for 
        select Heroes.name 
        from Heroes,
             SignatureHeroes
        where SignatureHeroes.playerId = p_PlayerId and
              Heroes.id = SignatureHeroes.heroId;

    return o_RC1;
end;
/

create or replace function PlayerAchievements(p_PlayerId in integer) return sys_refcursor
is
    o_RC1 sys_refcursor;
begin
    open o_RC1 for 
    select Teams.id,
           Tournaments.id,
           to_char(TournamentWinners.winDate, 'yyyy-mm-dd'), 
           TournamentWinners.place, 
           Teams.name, 
           Tournaments.name, 
           TournamentWinners.usd
    from TournamentWinners,
         Teams,
         Tournaments,
         TeamsPlayers
    where TeamsPlayers.playerId = p_PlayerId and
          Teams.id = TeamsPlayers.teamId and
          TournamentWinners.teamId = Teams.id and 
          TournamentWinners.winDate between TeamsPlayers.joinDate and TeamsPlayers.leaveDate and
          Tournaments.id = TournamentWinners.tournamentId; 

    return o_RC1;
end;
/


-- TOURNAMENT PAGE

create or replace function TournamentShortInfo(p_TournamentId in integer) return sys_refcursor
is
    o_RC1 sys_refcursor;
begin
    open o_RC1 for
        select name,
               format,
               type,
               gameVersion,
               to_char(startDate, 'yyyy-mm-dd'),
               to_char(endDate, 'yyyy-mm-dd'),
               prizePool
        from Tournaments
        where Tournaments.id = p_TournamentId and
              rownum = 1;

    return o_RC1;
end;
/

create or replace function TournamentSponsors(p_TournamentId in integer) return sys_refcursor
is  
    o_RC1 sys_refcursor;
begin
    open o_RC1 for 
        select Sponsors.url 
        from Sponsors,
             SponsorsTournaments
        where SponsorsTournaments.tournamentId = p_TournamentId and
              Sponsors.id = SponsorsTournaments.sponsorId;

    return o_RC1;
end;
/

create or replace function TournamentInvitedTeams(p_TournamentId in integer) return sys_refcursor
is
    o_RC1 sys_refcursor;
begin
    open o_RC1 for 
        select Teams.id,
               Teams.name
        from Teams,
             TournamentsTeams
        where TournamentsTeams.tournamentId = p_TournamentId and
              Teams.id = TournamentsTeams.teamId and
              TournamentsTeams.isInvited = '1';

    return o_RC1;
end;
/

create or replace function TournamentQualifiedTeams(p_TournamentId in integer) return sys_refcursor
is
    o_RC1 sys_refcursor;
begin
    open o_RC1 for 
        select Teams.id,
               Teams.name
        from Teams,
             TournamentsTeams
        where TournamentsTeams.tournamentId = p_TournamentId and
              Teams.id = TournamentsTeams.teamId and
              TournamentsTeams.isInvited = '0';

    return o_RC1;
end;
/

create or replace function TournamentTeamWinners(p_TournamentId in integer) return sys_refcursor
is
    o_RC1 sys_refcursor;
begin
    open o_RC1 for
        select Teams.id,
               TournamentWinners.place,
               TournamentWinners.usd,
               Teams.name
        from TournamentWinners,
             Teams
        where TournamentWinners.tournamentId = p_TournamentId and
              Teams.id = TournamentWinners.teamId and
              rownum <= 4
        order by TournamentWinners.place;

    return o_RC1;
end;
/

create or replace function TournamentMatches(p_TournamentId in integer) return sys_refcursor
is
    o_RC1 sys_refcursor;
begin
    open o_RC1 for
        select Matches.firstTeamId,
               Matches.secondTeamId,
               to_char(Matches.matchDate, 'yyyy-mm-dd'), 
               firstTeamName,
               Matches.firstTeamScore,
               Matches.secondTeamScore,
               secondTeamName
        from Matches,
            (select Teams.name as firstTeamName, Matches.id as p
             from Teams,
                  Matches
             where Teams.id = Matches.firstTeamId and 
                   Matches.tournamentId = p_TournamentId)
             join
            (select Teams.name as secondTeamName, Matches.id as m
             from Teams,
                  Matches
             where Teams.id = Matches.secondTeamId and 
                   Matches.TournamentId = p_TournamentId) 
             on p=m
        where Matches.id = p and 
              matches.tournamentid = p_TournamentId;
        

    return o_RC1; 
end;
/


-- START PAGE
create or replace function AllTeams return sys_refcursor
is
    o_RC1 sys_refcursor;
begin
    open o_RC1 for 
        select id, name 
        from Teams;

    return o_RC1;
end;
/

create or replace function AllPlayers return sys_refcursor
is
    o_RC1 sys_refcursor;
begin
    open o_RC1 for 
        select id, nickName 
        from Players;

    return o_RC1;
end;
/


create or replace function AllTournaments return sys_refcursor
is
    o_RC1 sys_refcursor;
begin
    open o_RC1 for 
        select id, name 
        from Tournaments;

    return o_RC1;
end;
/

-- ADMIN FUNCTIONS
create or replace function AllUsers return sys_refcursor
is
    o_RC1 sys_refcursor;
begin
    open o_RC1 for 
        select id, login 
        from Users;

    return o_RC1;
end;
/

create or replace function AllRoles return sys_refcursor
is
    o_RC1 sys_refcursor;
begin
    open o_RC1 for 
        select id, name
        from Roles;

    return o_RC1;
end;
/

create or replace function AllHeroes return sys_refcursor
is
    o_RC1 sys_refcursor;
begin
    open o_RC1 for 
        select id, name 
        from Heroes;

    return o_RC1;
end;
/

create or replace function AllMatches return sys_refcursor
is
    o_RC1 sys_refcursor;
begin
    open o_RC1 for 
        select Matches.id, 
               Tournaments.name, 
               (select Teams.name
                from Teams
                where id = Matches.firstTeamId),
               (select Teams.name
                from Teams
                where id = Matches.secondTeamId)
        from Matches,
             Tournaments
        where Tournaments.id = Matches.tournamentId;              

    return o_RC1;
end;
/

create or replace function AllSponsors return sys_refcursor
is
    o_RC1 sys_refcursor;
begin
    open o_RC1 for
        select id, url
        from Sponsors;

    return o_RC1;
end;
/

create or replace function AllTournamentWinners return sys_refcursor
is
    o_RC1 sys_refcursor;
begin
    open o_RC1 for
        select TournamentWinners.id,
               Tournaments.name,
               Teams.name
        from TournamentWinners,
             Tournaments,
             Teams
        where Tournaments.id = TournamentWinners.tournamentId and
              Teams.id = TournamentWinners.teamId;

    return o_RC1;
end;
/

create or replace function AllSignatureHeroes return sys_refcursor
is
    o_RC1 sys_refcursor;
begin
    open o_RC1 for 
        select SignatureHeroes.playerId,
               SignatureHeroes.heroId,
               Players.nickName,
               Heroes.name 
        from SignatureHeroes,
             Players,
             Heroes
        where Players.id = SignatureHeroes.playerId and
              Heroes.id = SignatureHeroes.heroId;

    return o_RC1;
end;
/


create or replace function AllSponsorsTournaments return sys_refcursor
is
    o_RC1 sys_refcursor;
begin
    open o_RC1 for 
        select SponsorsTournaments.sponsorId,
               SponsorsTournaments.tournamentId,
               Sponsors.url,
               Tournaments.name
        from SponsorsTournaments,
             Sponsors,
             Tournaments
        where Sponsors.id = SponsorsTournaments.sponsorId and 
              Tournaments.id = SponsorsTournaments.tournamentId;

    return o_RC1;
end;
/


create or replace function AllTeamsPlayers return sys_refcursor
is
    o_RC1 sys_refcursor;
begin
    open o_RC1 for 
        select TeamsPlayers.teamId,
               TeamsPlayers.playerId,
               Teams.name,
               Players.nickName
        from TeamsPlayers,
             Teams,
             Players
        where Players.id = TeamsPlayers.playerId and
              Teams.id = TeamsPlayers.teamId;

    return o_RC1;
end;
/


create or replace function AllTournamentsTeams return sys_refcursor
is
    o_RC1 sys_refcursor;
begin
    open o_RC1 for 
        select TournamentsTeams.tournamentId, 
               TournamentsTeams.teamId,
               Tournaments.name,
               Teams.name
        from TournamentsTeams,
             Tournaments,
             Teams
        where Tournaments.id = TournamentsTeams.tournamentId and
              Teams.id = TournamentsTeams.teamId;

    return o_RC1;
end;
/


create or replace function GetTeam(p_TeamId in integer) return sys_refcursor
is
    o_RC1 sys_refcursor;
begin
    open o_RC1 for
        select Teams.name,
               (select nickName 
                from Players
                where id = Teams.captainId),
               location,
               (select nickName 
                from Players
                where id = Teams.coachId)
        from Teams
        where id = p_TeamId;

    return o_RC1;
end;
/


create or replace function GetPlayer(p_PlayerId in integer) return sys_refcursor
is
    o_RC1 sys_refcursor;
begin
    open o_RC1 for
        select nickName,
               position,
               firstName,
               lastName,
               country
        from Players
        where id = p_PlayerId;

    return o_RC1;
end;
/


create or replace function GetTournament(p_TournamentId in integer) return sys_refcursor
is
    o_RC1 sys_refcursor;
begin
    open o_RC1 for
        select name,
               format,
               type,
               prizePool,
               to_char(startDate, 'yyyy-mm-dd'),
               to_char(endDate, 'yyyy-mm-dd'),
               gameVersion
        from Tournaments
        where id = p_TournamentId;

    return o_RC1;
end;
/


create or replace function GetUser(p_UserId in integer) return sys_refcursor
is
    o_RC1 sys_refcursor;
begin
    open o_RC1 for
        select login,
               password,
               (select name
                from Roles
                where id = Users.roleId)
        from Users
        where id = p_UserId;

    return o_RC1;
end;
/


create or replace function GetRole(p_RoleId in integer) return sys_refcursor
is
    o_RC1 sys_refcursor;
begin
    open o_RC1 for
        select name,
               priority
        from Roles
        where id = p_RoleId;

    return o_RC1;
end;
/


create or replace function GetHero(p_HeroId in integer) return sys_refcursor
is
    o_RC1 sys_refcursor;
begin
    open o_RC1 for
        select name
        from Heroes
        where id = p_HeroId;

    return o_RC1;
end;
/


create or replace function GetMatch(p_MatchId in integer) return sys_refcursor
is
    o_RC1 sys_refcursor;
begin
    open o_RC1 for
        select (select name
                from Tournaments
                where id = Matches.tournamentId),
                (select name
                from Teams
                where id = Matches.firstTeamId),
                (select name
                from Teams
                where id = Matches.secondTeamId),
                to_char(matchDate, 'yyyy-mm-dd'),
                bracketStage,
                firstTeamScore,
                secondTeamScore
        from Matches
        where id = p_MatchId;

    return o_RC1;
end;
/


create or replace function GetSponsor(p_SponsorId in integer) return sys_refcursor
is
    o_RC1 sys_refcursor;
begin
    open o_RC1 for
        select url
        from Sponsors
        where id = p_SponsorId;

    return o_RC1;
end;
/


create or replace function GetTournamentWinner(p_TournamentWinnerId in integer) return sys_refcursor
is
    o_RC1 sys_refcursor;
begin
    open o_RC1 for
        select (select name
                from Teams
                where id = TournamentWinners.teamId),
               (select name
                from Tournaments
                where id = TournamentWinners.tournamentId),
               to_char(winDate, 'yyyy-mm-dd'),
               place,
               usd
        from TournamentWinners
        where id = p_TournamentWinnerId;

    return o_RC1;
end;
/


create or replace function GetSignatureHero(p_PlayerId in integer, p_HeroId in integer) return sys_refcursor
is
    o_RC1 sys_refcursor;
begin
    open o_RC1 for
        select (select nickName
                from Players
                where id = p_PlayerId),
                (select name
                from Heroes
                where id = p_HeroId)
        from SignatureHeroes
        where playerId = p_PlayerId and
              heroId = p_HeroId;

    return o_RC1;
end;
/


create or replace function GetSponsorTournament(p_SponsorId in integer, p_TournamentId in integer) return sys_refcursor
is
    o_RC1 sys_refcursor;
begin
    open o_RC1 for
        select (select url
                from Sponsors
                where id = p_SponsorId),
                (select name
                from Tournaments
                where id = p_TournamentId)
        from SponsorsTournaments
        where sponsorId = p_SponsorId and
              tournamentId = p_TournamentId;

    return o_RC1;
end;
/


create or replace function GetTeamPlayer(p_TeamId in integer, p_PlayerId in integer) return sys_refcursor
is
    o_RC1 sys_refcursor;
begin
    open o_RC1 for
        select (select name
                from Teams
                where id = p_TeamId),
               (select nickName
                from Players
                where id = p_PlayerId),
               to_char(joinDate, 'yyyy-mm-dd'),
               to_char(leaveDate, 'yyyy-mm-dd')
        from TeamsPlayers
        where teamId = p_TeamId and
              playerId = p_PlayerId;

    return o_RC1;
end;
/


create or replace function GetTournamentTeam(p_TournamentId in integer, p_TeamId in integer) return sys_refcursor
is
    o_RC1 sys_refcursor;
begin
    open o_RC1 for
        select (select name
                from Tournaments
                where id = p_TournamentId),
               (select name
                from Teams
                where id = p_TeamId),
               isInvited
        from TournamentsTeams
        where tournamentId = p_TournamentId and
              teamId = p_TeamId;

    return o_RC1;
end;
/

