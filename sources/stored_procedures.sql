create or replace procedure AddRole(p_RoleName in varchar2, p_RolePriority in integer)
is
begin
    insert into Roles (name, priority)
        values (p_RoleName, p_RolePriority);
end;
/
create or replace procedure DeleteRole(p_RoleId in integer)
is
begin
    delete from Roles
    where id = p_RoleId;
end;
/
create or replace procedure UpdateRole(p_RoleId in integer, p_RoleName in varchar2, p_RolePriority in integer)
is
begin
    update Roles
    set name = p_RoleName,
        priority = p_RolePriority
    where id = p_RoleId;  
end;
/


create or replace procedure AddUser(p_Login in varchar2, p_Password in varchar2, p_RoleName in varchar2 default 'user')
is
    l_RoleId integer;
begin
    select id into l_RoleId
    from Roles
    where name = p_RoleName;

    insert into Users (login, password, roleId)
        values (p_Login, p_Password, l_RoleId);
end;
/
create or replace procedure DeleteUser(p_UserId in integer)
is
begin
    delete from Users
    where id = p_UserId;
end;
/
create or replace procedure UpdateUser(p_UserId in varchar2, p_Login in varchar2, p_Password in varchar2, p_RoleName in varchar2 default 'user')
is
    l_RoleId integer;
begin
    select id into l_RoleId
    from Roles
    where name = p_RoleName;

    update Users 
    set login = p_Login, 
        password = p_Password,
        roleId = l_RoleId
    where id = p_UserId;
end;
/


create or replace procedure AddHero(p_Name in varchar2)
is
begin
    insert into Heroes (name) 
        values (p_Name);
end;
/
create or replace procedure DeleteHero(p_HeroId in integer)
is
begin
    delete from Heroes
    where id = p_HeroId;
end;
/
create or replace procedure UpdateHero(p_HeroId in integer, p_HeroName in varchar2)
is
begin
    update Heroes
    set name = p_HeroName
    where id = p_HeroId;
end;
/


create or replace procedure AddPlayer(p_NickName in varchar2, p_Position in integer, p_FirstName in varchar2, p_LastName in varchar2, p_Country in varchar2)
is 
begin
    insert into Players (nickName, position, firstName, lastName, country) 
        values (p_NickName, p_Position, p_FirstName, p_LastName, p_Country);
end;
/
create or replace procedure DeletePlayer(p_PlayerId in integer)
is
begin
    delete from Players
    where id = p_PlayerId; 
end;
/
create or replace procedure UpdatePlayer(p_PlayerId in integer, 
        p_NickName in varchar2, p_Position in integer, p_FirstName in varchar2, p_LastName in varchar2, p_Country in varchar2)
is 
begin
    update Players
    set nickName = p_NickName,
        position = p_Position,
        firstName = p_FirstName,
        lastName = p_LastName,
        country = p_Country
    where id = p_PlayerId;
end;
/


create or replace procedure AddTeam(p_Name in varchar2, p_captainNickName in varchar2, p_Location in varchar2, p_CoachNickName in varchar2 default null)
is
    l_captainId integer;
    l_CoachId integer := null;
begin
    select id into l_captainId 
    from Players 
    where nickName = p_captainNickName;

    if p_CoachNickName is not null then
        select id into l_CoachId 
        from Players 
        where nickName = p_CoachNickName;
    end if;

    insert into Teams (name, captainId, coachId, location) 
        values (p_Name, l_captainId, l_CoachId, p_Location);
end;
/
create or replace procedure DeleteTeam(p_TeamId in integer)
is
begin
    delete from Teams 
    where id = p_TeamId; 

end;
/
create or replace procedure UpdateTeam(p_TeamId in integer, p_Name in varchar2, p_captainNickName in varchar2, p_Location in varchar2, p_CoachNickName in varchar2 default null)
is
    l_captainId integer;
    l_CoachId integer := null;
begin
    select id into l_captainId 
    from Players 
    where nickName = p_captainNickName;

    if p_CoachNickName is not null then
        select id into l_CoachId 
        from Players 
        where nickName = p_CoachNickName;
    end if;

    update Teams
    set name = p_Name,
        captainId = l_captainId,
        coachId = l_CoachId,
        location = p_Location
    where id = p_TeamId;
end;
/


create or replace procedure AddTournament(p_Name in varchar2, p_Format in varchar2, p_Type in varchar2, 
    p_PrizePool in integer, p_StartDate in varchar2, p_EndDate in varchar2, p_GameVersion in varchar2)
is
begin
    insert into Tournaments (name, format, type, prizePool, startDate, endDate, gameVersion)
        values (
            p_Name, 
            p_Format, 
            p_Type, 
            p_PrizePool, 
            to_date(p_StartDate, 'yyyy-mm-dd'),
            to_date(p_EndDate, 'yyyy-mm-dd'), 
            p_GameVersion
            );
end;
/
create or replace procedure DeleteTournament(p_TournamentId in integer)
is
begin
    delete from Tournaments 
    where id = p_TournamentId;
end;
/
create or replace procedure UpdateTournament(p_TournamentId in integer, p_Name in varchar2, p_Format in varchar2, p_Type in varchar2, 
    p_PrizePool in integer, p_StartDate in varchar2, p_EndDate in varchar2, p_GameVersion in varchar2)
is
    l_FormatId integer;
    l_TournamentTypeId integer;
begin
    update Tournaments
    set name = p_Name,
        format = p_Format,
        type = p_Type,
        prizePool = p_PrizePool,
        startDate = to_date(p_StartDate, 'yyyy-mm-dd'),
        endDate = to_date(p_EndDate, 'yyyy-mm-dd'),
        gameVersion = p_GameVersion
    where id = p_TournamentId;
end;
/


create or replace procedure AddMatch(p_TournamentName in varchar2, p_FirstTeamName in varchar2, p_SecondTeamName in varchar2, 
    p_MatchDate in varchar2, p_BracketStage in varchar2, p_FirstTeamScore in integer, p_SecondTeamScore in integer)
is
    l_TournamentId integer;
    l_FirstTeamId integer;
    l_SecondTeamId integer;
begin
    select id into l_TournamentId 
    from Tournaments
    where name = p_TournamentName;
    
    select id into l_FirstTeamId 
    from Teams
    where name = p_FirstTeamName;
    
    select id into l_SecondTeamId 
    from Teams
    where name = p_SecondTeamName;
    
    insert into Matches (tournamentId, firstTeamId, secondTeamId, matchDate, bracketStage, firstTeamScore, secondTeamScore)
        values (
            l_TournamentId, 
            l_FirstTeamId, 
            l_SecondTeamId, 
            to_date(p_MatchDate, 'yyyy-mm-dd'),
            p_BracketStage, 
            p_FirstTeamScore,
            p_SecondTeamScore
            );
end;
/
create or replace procedure DeleteMatch(p_MatchId in integer)
is
begin
    delete from Matches
    where id = p_MatchId; 

end;
/
create or replace procedure UpdateMatch(p_MatchId in integer, p_TournamentName in varchar2, p_FirstTeamName in varchar2, p_SecondTeamName in varchar2, 
    p_MatchDate in varchar2, p_BracketStage in varchar2, p_FirstTeamScore in integer, p_SecondTeamScore in integer)
is
    l_TournamentId integer;
    l_FirstTeamId integer;
    l_SecondTeamId integer;
begin
    select id into l_TournamentId 
    from Tournaments
    where name = p_TournamentName;
    
    select id into l_FirstTeamId 
    from Teams
    where name = p_FirstTeamName;
    
    select id into l_SecondTeamId 
    from Teams
    where name = p_SecondTeamName;

    update Matches
    set tournamentId = l_TournamentId,
        firstTeamId = l_FirstTeamId,
        secondTeamId = l_SecondTeamId,
        matchDate = to_date(p_MatchDate, 'yyyy-mm-dd'),
        bracketStage = p_BracketStage,
        firstTeamScore = p_FirstTeamScore,
        secondTeamScore = p_SecondTeamScore
    where id = p_MatchId;
end;
/


create or replace procedure AddSponsor(p_Url in varchar2)
is
begin
    insert into Sponsors (url) 
        values (p_Url);
end;
/
create or replace procedure DeleteSponsor(p_SponsorId in integer)
is
begin
    delete from Sponsors 
    where id = p_SponsorId;

end;
/
create or replace procedure UpdateSponsor(p_SponsorId in integer, p_Url in varchar2)
is
begin
    update Sponsors
    set url = p_Url
    where id = p_SponsorId;
end;
/


create or replace procedure AddTournamentWinner(p_TeamName in varchar2, p_TournamentName in varchar2, p_Date in varchar2, p_Place in integer, p_Usd in integer default 0)
is
    l_TeamId integer;
    l_TournamentId integer;
begin
    select id into l_TeamId 
    from Teams 
    where name = p_TeamName;
    
    select id into l_TournamentId 
    from Tournaments 
    where name = p_TournamentName;
    
    insert into TournamentWinners (teamId, tournamentId, winDate, place, usd) 
        values (l_TeamId, 
                l_TournamentId, 
                to_date(p_Date, 'yyyy-mm-dd'), 
                p_Place, 
                p_Usd);
end;
/
create or replace procedure DeleteTournamentWinner(p_TournamentWinnerId in integer)
is
begin
    delete from TournamentWinners
    where id = p_TournamentWinnerId;

end;
/
create or replace procedure UpdateTournamentWinner(p_TournamentWinnerId in integer, p_TeamName in varchar2, p_TournamentName in varchar2, p_Date in varchar2, p_Place in integer, p_Usd in integer default 0)
is
    l_TeamId integer;
    l_TournamentId integer;
begin
    select id into l_TeamId 
    from Teams 
    where name = p_TeamName;
    
    select id into l_TournamentId 
    from Tournaments 
    where name = p_TournamentName;

    update TournamentWinners
    set teamId = l_TeamId,
        tournamentId = l_TournamentId,
        winDate = to_date(p_Date, 'yyyy-mm-dd'),
        place = p_Place,
        usd = p_Usd
    where id = p_TournamentWinnerId;
end;
/


create or replace procedure AddSignatureHero(p_NickName in varchar2, p_HeroName in varchar2)
is
    l_PlayerId integer;
    l_HeroId integer;
begin
    select id into l_PlayerId 
    from Players
    where nickName = p_NickName;
    
    select id into l_HeroId 
    from Heroes 
    where name = p_HeroName;
    
    insert into SignatureHeroes (playerId, heroId) 
        values (l_PlayerId, l_HeroId);
end;
/
create or replace procedure DeleteSignatureHero(p_PlayerId in integer, p_HeroId in integer)
is
begin
    delete from SignatureHeroes 
    where playerId = p_PlayerId and 
          heroId = p_HeroId;
end;
/
create or replace procedure UpdateSignatureHero(p_PlayerId in integer, p_HeroId in integer, p_NickName in varchar2, p_HeroName in varchar2)
is
    l_PlayerId integer;
    l_HeroId integer;
begin
    select id into l_PlayerId 
    from Players 
    where nickName = p_NickName;
    
    select id into l_HeroId 
    from Heroes 
    where name = p_HeroName;

    update SignatureHeroes
    set playerId = l_PlayerId,
        heroId = l_HeroId
    where playerId = p_PlayerId and
          heroId = p_HeroId;
end;
/


create or replace procedure AddSponsorTournament(p_SponsorUrl in varchar2, p_TournamentName in varchar2) 
is
    l_SponsorId integer;
    l_TournamentId integer;
begin
    select id into l_SponsorId 
    from Sponsors 
    where url = p_SponsorUrl;
    
    select id into l_TournamentId 
    from Tournaments 
    where name = p_TournamentName;
    
    insert into SponsorsTournaments (sponsorId, tournamentId) 
        values (l_SponsorId, l_TournamentId);
end;
/
create or replace procedure DeleteSponsorTournament(p_SponsorId in integer, p_TournamentId in integer) 
is
begin
    delete from SponsorsTournaments 
    where sponsorId = p_SponsorId and 
          tournamentId = p_TournamentId;

end;
/
create or replace procedure UpdateSponsorTournament(p_SponsorId in integer, p_TournamentId in integer,
    p_SponsorUrl in varchar2, p_TournamentName in varchar2)
is
    l_SponsorId integer;
    l_TournamentId integer;
begin
    select id into l_SponsorId 
    from Sponsors 
    where url = p_SponsorUrl;
    
    select id into l_TournamentId 
    from Tournaments 
    where name = p_TournamentName;
    
    update SponsorsTournaments
    set sponsorId = l_SponsorId,
        tournamentId = tournamentId
    where sponsorId = p_SponsorId and
          tournamentId = p_TournamentId;
end;
/


create or replace procedure AddTeamPlayer(p_TeamName in varchar2, p_NickName in varchar2, 
    p_JoinDate in varchar2, p_LeaveDate in varchar2 default '9999-12-01') 
is
    l_TeamId integer;
    l_PlayerId integer;
    l_LeaveDate timestamp;
begin
    select id into l_TeamId 
    from Teams 
    where name = p_TeamName;
    
    select id into l_PlayerId 
    from Players
    where nickName = p_NickName;

    insert into TeamsPlayers (teamId, playerId, joinDate, leaveDate) 
        values (
            l_TeamId, 
            l_PlayerId, 
            to_date(p_JoinDate, 'yyyy-mm-dd'), 
            to_date(p_LeaveDate, 'yyyy-mm-dd')
            );
end;
/
create or replace procedure DeleteTeamPlayer(p_TeamId in integer, p_PlayerId in integer)
is
begin
    delete from TeamsPlayers
    where teamId = p_TeamId and 
          playerId = p_PlayerId;
end;
/
create or replace procedure UpdateTeamPlayer(p_TeamId in integer, p_PlayerId in integer, p_TeamName in varchar2, p_NickName in varchar2, 
    p_JoinDate in varchar2, p_LeaveDate in varchar2 default '9999-12-01') 
is
    l_TeamId integer;
    l_PlayerId integer;
    l_LeaveDate timestamp;
begin
    select id into l_TeamId 
    from Teams 
    where name = p_TeamName;
    
    select id into l_PlayerId 
    from Players 
    where nickName = p_NickName;

    update TeamsPlayers
    set teamId = l_TeamId,
        playerId = l_PlayerId,
        joinDate = to_date(p_JoinDate, 'yyyy-mm-dd'), 
        leaveDate = to_date(p_LeaveDate, 'yyyy-mm-dd')
    where teamId = p_TeamId and
          playerId = p_PlayerId;
end;
/


create or replace procedure AddTournamentTeam(p_TournamentName in varchar2, p_TeamName in varchar2, p_IsInvited char) 
is
    l_TournamentId integer;
    l_TeamId integer;
begin
    select id into l_TournamentId 
    from Tournaments
    where name = p_TournamentName;
    
    select id into l_TeamId 
    from Teams 
    where name = p_TeamName;
    
    insert into TournamentsTeams (tournamentId, teamId, isInvited) 
        values (l_TournamentId, l_TeamId, p_IsInvited);
end;
/
create or replace procedure DeleteTournamentTeam(p_TournamentId in integer, p_TeamId in integer) 
is
    l_TournamentId integer;
    l_TeamId integer;
begin
    delete from TournamentsTeams 
    where tournamentId = p_TournamentId and 
          teamId = p_TeamId;
end;
/
create or replace procedure UpdateTournamentTeam(p_TournamentId in integer, p_TeamId in integer, p_TournamentName in varchar2, p_TeamName in varchar2, p_IsInvited in char)
is
    l_TournamentId integer;
    l_TeamId integer;
begin
    select id into l_TournamentId 
    from Tournaments
    where name = p_TournamentName;
    
    select id into l_TeamId 
    from Teams 
    where name = p_TeamName;

    update TournamentsTeams
    set tournamentId = l_TournamentId,
        teamId = l_TeamId,
        isInvited = p_IsInvited
    where tournamentId = p_TournamentId and
          teamId = p_TeamId;
end;
/