from django.shortcuts import render, redirect
from django.db import connection
from django.contrib.auth.hashers import MD5PasswordHasher
from django.db.utils import IntegrityError
from django.http import HttpResponseRedirect


from .forms import *
import cx_Oracle


g_Salt = '12345'
g_UserLogin = ''
g_Cursor = connection.cursor()


def get_access(role):
    return bool(int(g_Cursor.callfunc('RightAccess', cx_Oracle.NUMBER, [g_UserLogin, role])))


def register(request):
    error = ''
    if request.method == 'POST':
        form = RegisterForm(request.POST)
        if form.is_valid():
            login = form.cleaned_data['login']
            password = form.cleaned_data['password']
            password_confirm = form.cleaned_data['passwordConfirm']
            if password != password_confirm:
                error = "Passwords doesn't match"

            if not error:
                hasher = MD5PasswordHasher()
                crypted_password = MD5PasswordHasher.encode(hasher, password, g_Salt)

                try:
                    g_Cursor.callproc('AddUser', [login, crypted_password])
                except IntegrityError:
                    error = 'Such user is already exist'

            if not error:
                return redirect('login')
    else:
        form = RegisterForm()

    context = {'error': error, 'form': form}
    return render(request, 'dota_wiki/register.html', context)


def login(request):
    if request.method == 'POST':
        form = LoginForm(request.POST)
        if form.is_valid():
            login = form.cleaned_data['login']
            password = form.cleaned_data['password']
            hasher = MD5PasswordHasher()
            crypted_password = MD5PasswordHasher.encode(hasher, password, g_Salt)

            isExist = bool(int(g_Cursor.callfunc('AuthorizeUser', cx_Oracle.NUMBER, [login, crypted_password])))

            if isExist:
                global g_UserLogin
                g_UserLogin = login
                return redirect('index')
            else:
                return render(request, 'dota_wiki/login.html', {'error': 'Such user is not exist', 'form': form})
    else:
        form = LoginForm()

    return render(request, 'dota_wiki/login.html', {'form': form})


def logout(request):
    global g_UserLogin
    g_UserLogin = ''
    return redirect('index')


def admin(request):
    if get_access('admin'):
        return render(request, 'dota_wiki/admin.html', {'user': g_UserLogin})
    else:
        return render(request, 'dota_wiki/non-authorized.html', {'user': g_UserLogin})


def index(request):
    if get_access('user'):
        return render(request, 'dota_wiki/index.html', {'user': g_UserLogin})
    else:
        return render(request, 'dota_wiki/non-authorized.html', {'user': g_UserLogin})


def team_list(request):
    if get_access('user'):
        client_cursor = g_Cursor.callfunc('AllTeams', cx_Oracle.CURSOR)
        data = client_cursor.fetchall()
        context = {'user': g_UserLogin, 'teams': data}
        return render(request, 'dota_wiki/team_list.html', context)
    else:
        return render(request, 'dota_wiki/non-authorized.html', {'user': g_UserLogin})


def player_list(request):
    if get_access('user'):
        client_cursor = g_Cursor.callfunc('AllPlayers', cx_Oracle.CURSOR)
        data = client_cursor.fetchall()
        context = {'user': g_UserLogin, 'players': data}
        return render(request, 'dota_wiki/player_list.html', context)
    else:
        return render(request, 'dota_wiki/non-authorized.html', {'user': g_UserLogin})


def tournament_list(request):
    if get_access('user'):
        client_cursor = g_Cursor.callfunc('AllTournaments', cx_Oracle.CURSOR)
        data = client_cursor.fetchall()
        context = {'user': g_UserLogin, 'tournaments': data}
        return render(request, 'dota_wiki/tournament_list.html', context)
    else:
        return render(request, 'dota_wiki/non-authorized.html', {'user': g_UserLogin})


def team(request, pk):
    if get_access('user'):
        short_info = g_Cursor.callfunc('TeamShortInfo', cx_Oracle.CURSOR, [pk]).fetchall()[0]
        current_roster = g_Cursor.callfunc('TeamCurrentRoster', cx_Oracle.CURSOR, [pk]).fetchall()
        former_players = g_Cursor.callfunc('TeamFormerPlayers', cx_Oracle.CURSOR, [pk]).fetchall()
        achievements = g_Cursor.callfunc('TeamAchievements', cx_Oracle.CURSOR, [pk]).fetchall()
        context = {
                    'user': g_UserLogin,
                    'shortInfo': short_info,
                    'currentRoster': current_roster,
                    'formerPlayers': former_players,
                    'achievements': achievements
        }
        return render(request, 'dota_wiki/team.html', context)
    else:
        return render(request, 'dota_wiki/non-authorized.html', {'user': g_UserLogin})


def player(request, pk):
    if get_access('user'):
        short_info = g_Cursor.callfunc('PlayerShortInfo', cx_Oracle.CURSOR, [pk]).fetchall()
        signature_heroes = g_Cursor.callfunc('PlayerSignatureHeroes', cx_Oracle.CURSOR, [pk]).fetchall()
        previous_teams = g_Cursor.callfunc('PlayerPreviousTeams', cx_Oracle.CURSOR, [pk]).fetchall()
        achievements = g_Cursor.callfunc('PlayerAchievements', cx_Oracle.CURSOR, [pk]).fetchall()

        context = {
                    'user': g_UserLogin,
                    'shortInfo': short_info[0] if short_info else None,
                    'signatureHeroes': signature_heroes,
                    'previousTeams': previous_teams,
                    'achievements': achievements
        }
        return render(request, 'dota_wiki/player.html', context)
    else:
        return render(request, 'dota_wiki/non-authorized.html', {'user': g_UserLogin})


def tournament(request, pk):
    if get_access('user'):
        short_info = g_Cursor.callfunc('TournamentShortInfo', cx_Oracle.CURSOR, [pk]).fetchall()[0]
        sponsors = g_Cursor.callfunc('TournamentSponsors', cx_Oracle.CURSOR, [pk]).fetchall()
        invited_teams = g_Cursor.callfunc('TournamentInvitedTeams', cx_Oracle.CURSOR, [pk]).fetchall()
        qualified_teams = g_Cursor.callfunc('TournamentQualifiedTeams', cx_Oracle.CURSOR, [pk]).fetchall()
        team_winners = g_Cursor.callfunc('TournamentTeamWinners', cx_Oracle.CURSOR, [pk]).fetchall()
        matches = g_Cursor.callfunc('TournamentMatches', cx_Oracle.CURSOR, [pk]).fetchall()
        context = {
                    'user': g_UserLogin,
                    'shortInfo': short_info,
                    'sponsors': sponsors,
                    'invitedTeams': invited_teams,
                    'qualifiedTeams': qualified_teams,
                    'teamWinners': team_winners,
                    'matches': matches
        }
        return render(request, 'dota_wiki/tournament.html', context)
    else:
        return render(request, 'dota_wiki/non-authorized.html', {'user': g_UserLogin})


def admin_team_list(request):
    if get_access('admin'):
        client_cursor = g_Cursor.callfunc('AllTeams', cx_Oracle.CURSOR)
        data = client_cursor.fetchall()
        context = {'user': g_UserLogin, 'teams': data}
        return render(request, 'dota_wiki/admin/team_list.html', context)
    else:
        return render(request, 'dota_wiki/non-authorized.html', {'user': g_UserLogin})


def admin_player_list(request):
    if get_access('admin'):
        client_cursor = g_Cursor.callfunc('AllPlayers', cx_Oracle.CURSOR)
        data = client_cursor.fetchall()
        context = {'user': g_UserLogin, 'players': data}
        return render(request, 'dota_wiki/admin/player_list.html', context)
    else:
        return render(request, 'dota_wiki/non-authorized.html', {'user': g_UserLogin})


def admin_tournament_list(request):
    if get_access('admin'):
        client_cursor = g_Cursor.callfunc('AllTournaments', cx_Oracle.CURSOR)
        data = client_cursor.fetchall()
        context = {'user': g_UserLogin, 'tournaments': data}
        return render(request, 'dota_wiki/admin/tournament_list.html', context)
    else:
        return render(request, 'dota_wiki/non-authorized.html', {'user': g_UserLogin})


def admin_user_list(request):
    if get_access('admin'):
        client_cursor = g_Cursor.callfunc('AllUsers', cx_Oracle.CURSOR)
        data = client_cursor.fetchall()
        context = {'user': g_UserLogin, 'users': data}
        return render(request, 'dota_wiki/admin/user_list.html', context)
    else:
        return render(request, 'dota_wiki/non-authorized.html', {'user': g_UserLogin})


def admin_role_list(request):
    if get_access('admin'):
        client_cursor = g_Cursor.callfunc('AllRoles', cx_Oracle.CURSOR)
        data = client_cursor.fetchall()
        context = {'user': g_UserLogin, 'roles': data}
        return render(request, 'dota_wiki/admin/role_list.html', context)
    else:
        return render(request, 'dota_wiki/non-authorized.html', {'user': g_UserLogin})


def admin_hero_list(request):
    if get_access('admin'):
        client_cursor = g_Cursor.callfunc('AllHeroes', cx_Oracle.CURSOR)
        data = client_cursor.fetchall()
        context = {'user': g_UserLogin, 'heroes': data}
        return render(request, 'dota_wiki/admin/hero_list.html', context)
    else:
        return render(request, 'dota_wiki/non-authorized.html', {'user': g_UserLogin})


def admin_match_list(request):
    if get_access('admin'):
        client_cursor = g_Cursor.callfunc('AllMatches', cx_Oracle.CURSOR)
        data = client_cursor.fetchall()
        context = {'user': g_UserLogin, 'matches': data}
        return render(request, 'dota_wiki/admin/match_list.html', context)
    else:
        return render(request, 'dota_wiki/non-authorized.html', {'user': g_UserLogin})


def admin_sponsor_list(request):
    if get_access('admin'):
        client_cursor = g_Cursor.callfunc('AllSponsors', cx_Oracle.CURSOR)
        data = client_cursor.fetchall()
        context = {'user': g_UserLogin, 'sponsors': data}
        return render(request, 'dota_wiki/admin/sponsor_list.html', context)
    else:
        return render(request, 'dota_wiki/non-authorized.html', {'user': g_UserLogin})


def admin_tournament_winner_list(request):
    if get_access('admin'):
        client_cursor = g_Cursor.callfunc('AllTournamentWinners', cx_Oracle.CURSOR)
        data = client_cursor.fetchall()
        context = {'user': g_UserLogin, 'tournamentWinners': data}
        return render(request, 'dota_wiki/admin/tournament_winner_list.html', context)
    else:
        return render(request, 'dota_wiki/non-authorized.html', {'user': g_UserLogin})


def admin_signature_hero_list(request):
    if get_access('admin'):
        client_cursor = g_Cursor.callfunc('AllSignatureHeroes', cx_Oracle.CURSOR)
        data = client_cursor.fetchall()
        context = {'user': g_UserLogin, 'signatureHeroes': data}
        return render(request, 'dota_wiki/admin/signature_hero_list.html', context)
    else:
        return render(request, 'dota_wiki/non-authorized.html', {'user': g_UserLogin})


def admin_sponsor_tournament_list(request):
    if get_access('admin'):
        client_cursor = g_Cursor.callfunc('AllSponsorsTournaments', cx_Oracle.CURSOR)
        data = client_cursor.fetchall()
        context = {'user': g_UserLogin, 'sponsorsTournaments': data}
        return render(request, 'dota_wiki/admin/sponsor_tournament_list.html', context)
    else:
        return render(request, 'dota_wiki/non-authorized.html', {'user': g_UserLogin})


def admin_team_player_list(request):
    if get_access('admin'):
        client_cursor = g_Cursor.callfunc('AllTeamsPlayers', cx_Oracle.CURSOR)
        data = client_cursor.fetchall()
        context = {'user': g_UserLogin, 'teamsPlayers': data}
        return render(request, 'dota_wiki/admin/team_player_list.html', context)
    else:
        return render(request, 'dota_wiki/non-authorized.html', {'user': g_UserLogin})


def admin_tournament_team_list(request):
    if get_access('admin'):
        client_cursor = g_Cursor.callfunc('AllTournamentsTeams', cx_Oracle.CURSOR)
        data = client_cursor.fetchall()
        context = {'user': g_UserLogin, 'tournamentsTeams': data}
        return render(request, 'dota_wiki/admin/tournament_team_list.html', context)
    else:
        return render(request, 'dota_wiki/non-authorized.html', {'user': g_UserLogin})


# ----------------------------Forms---------------------------------------
# ----------------------------TEAM-----------------------------------------
def admin_team_new(request):
    if get_access('admin'):
        error = ''
        if request.method == 'POST':
            form = TeamForm(request.POST)
            if form.is_valid():
                params = [
                    form.cleaned_data['name'],
                    form.cleaned_data['captainName'],
                    form.cleaned_data['location'],
                    form.cleaned_data['coachName']
                ]

                try:
                    g_Cursor.callproc('AddTeam', params)
                except IntegrityError:
                    error = 'Such team is already exist'

                if not error:
                    return redirect('admin_team_list')
        else:
            form = TeamForm()

        context = {'user': g_UserLogin, 'error': error, 'form': form}
        return render(request, 'dota_wiki/admin/team_new.html', context)
    else:
        return render(request, 'dota_wiki/non-authorized.html', {'user': g_UserLogin})


def admin_team_edit(request, pk):
    if get_access('admin'):
        if request.method == 'POST':
            form = TeamForm(request.POST)
            if form.is_valid():
                params = [
                    form.cleaned_data['name'],
                    form.cleaned_data['captainName'],
                    form.cleaned_data['location'],
                    form.cleaned_data['coachName']
                ]
                g_Cursor.callproc('UpdateTeam', [pk] + params)

                return redirect('admin_team_list')
        else:
            client_cursor = g_Cursor.callfunc('GetTeam', cx_Oracle.CURSOR, [pk])
            data = client_cursor.fetchall()
            if data:
                data = data[0]
            else:
                return render(request, 'dota_wiki/record_404.html', {})
            
            form = TeamForm(initial={
                'name': data[0],
                'captainName': data[1],
                'location': data[2],
                'coachName': data[3]
            })

        context = {'user': g_UserLogin, 'form': form, 'pk': pk}
        return render(request, 'dota_wiki/admin/team_edit.html', context)
    else:
        return render(request, 'dota_wiki/non-authorized.html', {'user': g_UserLogin})


def admin_team_remove(request, pk):
    if get_access('admin'):
        g_Cursor.callproc('DeleteTeam', [pk])
        return redirect('admin_team_list')
    else:
        return render(request, 'dota_wiki/non-authorized.html', {'user': g_UserLogin})


# ------------------------------PLAYER----------------------------------------------
def admin_player_new(request):
    if get_access('admin'):
        error = ''
        if request.method == 'POST':
            form = PlayerForm(request.POST)
            if form.is_valid():
                params = [
                    form.cleaned_data['nickName'],
                    form.cleaned_data['position'],
                    form.cleaned_data['firstName'],
                    form.cleaned_data['lastName'],
                    form.cleaned_data['country'],
                ]
                try:
                    g_Cursor.callproc('AddPlayer', params)
                except IntegrityError:
                    error = 'Such player is already exist'

                if not error:
                    return redirect('admin_player_list')
        else:
            form = PlayerForm()

        context = {'user': g_UserLogin, 'error': error, 'form': form}
        return render(request, 'dota_wiki/admin/player_new.html', context)
    else:
        return render(request, 'dota_wiki/non-authorized.html', {'user': g_UserLogin})


def admin_player_edit(request, pk):
    if get_access('admin'):
        if request.method == 'POST':
            form = PlayerForm(request.POST)
            if form.is_valid():
                params = [
                    form.cleaned_data['nickName'],
                    form.cleaned_data['position'],
                    form.cleaned_data['firstName'],
                    form.cleaned_data['lastName'],
                    form.cleaned_data['country']
                ]
                g_Cursor.callproc('UpdatePlayer', [pk] + params)

                return redirect('admin_player_list')
        else:
            client_cursor = g_Cursor.callfunc('GetPlayer', cx_Oracle.CURSOR, [pk])
            data = client_cursor.fetchall()
            if data:
                data = data[0]
            else:
                return render(request, 'dota_wiki/record_404.html', {})
            
            form = PlayerForm(initial={
                'nickName': data[0],
                'position': data[1],
                'firstName': data[2],
                'lastName': data[3],
                'country': data[4]
            })

        context = {'user': g_UserLogin, 'form': form, 'pk': pk}
        return render(request, 'dota_wiki/admin/player_edit.html', context)
    else:
        return render(request, 'dota_wiki/non-authorized.html', {'user': g_UserLogin})


def admin_player_remove(request, pk):
    if get_access('admin'):
        g_Cursor.callproc('DeletePlayer', [pk])
        return redirect('admin_player_list')
    else:
        return render(request, 'dota_wiki/non-authorized.html', {'user': g_UserLogin})


# ---------------------------------TOURNAMENT---------------------------
def admin_tournament_new(request):
    if get_access('admin'):
        error = ''
        if request.method == 'POST':
            form = TournamentForm(request.POST)
            if form.is_valid():
                params = [
                    form.cleaned_data['name'],
                    form.cleaned_data['type'],
                    form.cleaned_data['format'],
                    form.cleaned_data['prizePool'],
                    form.cleaned_data['startDate'].strftime('%Y-%m-%d'),
                    form.cleaned_data['endDate'].strftime('%Y-%m-%d'),
                    form.cleaned_data['gameVersion']
                ]

                try:
                    g_Cursor.callproc('AddTournament', params)
                except IntegrityError:
                    error = 'Such tournament is already exist'

                if not error:
                    return redirect('admin_tournament_list')
        else:
            form = TournamentForm()

        context = {'user': g_UserLogin, 'error': error, 'form': form}
        return render(request, 'dota_wiki/admin/tournament_new.html', context)
    else:
        return render(request, 'dota_wiki/non-authorized.html', {'user': g_UserLogin})


def admin_tournament_edit(request, pk):
    if get_access('admin'):
        if request.method == 'POST':
            form = TournamentForm(request.POST)
            if form.is_valid():
                params = [
                    form.cleaned_data['name'],
                    form.cleaned_data['type'],
                    form.cleaned_data['format'],
                    form.cleaned_data['prizePool'],
                    form.cleaned_data['startDate'].strftime('%Y-%m-%d'),
                    form.cleaned_data['endDate'].strftime('%Y-%m-%d'),
                    form.cleaned_data['gameVersion'],
                    ]
                g_Cursor.callproc('UpdateTournament', [pk] + params)

                return redirect('admin_tournament_list')
        else:
            client_cursor = g_Cursor.callfunc('GetTournament', cx_Oracle.CURSOR, [pk])
            data = client_cursor.fetchall()
            if data:
                data = data[0]
            else:
                return render(request, 'dota_wiki/record_404.html', {})
            
            form = TournamentForm(initial={
                'name': data[0],
                'type': data[1],
                'format': data[2],
                'prizePool': data[3],
                'startDate': data[4],
                'endDate': data[5],
                'gameVersion': data[6]
            })

        context = {'user': g_UserLogin, 'form': form, 'pk': pk}
        return render(request, 'dota_wiki/admin/tournament_edit.html', context)
    else:
        return render(request, 'dota_wiki/non-authorized.html', {'user': g_UserLogin})


def admin_tournament_remove(request, pk):
    if get_access('admin'):
        g_Cursor.callproc('DeleteTournament', [pk])
        return redirect('admin_tournament_list')
    else:
        return render(request, 'dota_wiki/non-authorized.html', {'user': g_UserLogin})


# ---------------------------------USER--------------------------------------------
def admin_user_new(request):
    if get_access('admin'):
        error = ''
        if request.method == 'POST':
            form = UserForm(request.POST)
            if form.is_valid():
                params = [
                    form.cleaned_data['login'],
                    form.cleaned_data['password'],
                    form.cleaned_data['roleName']
                ]
                try:
                    g_Cursor.callproc('AddUser', params)
                except IntegrityError:
                    error = 'Such user is already exist'

                if not error:
                    return redirect('admin_user_list')
        else:
            form = UserForm()

        context = {'user': g_UserLogin, 'error': error, 'form': form}
        return render(request, 'dota_wiki/admin/user_new.html', context)
    else:
        return render(request, 'dota_wiki/non-authorized.html', {'user': g_UserLogin})


def admin_user_edit(request, pk):
    if get_access('admin'):
        if request.method == 'POST':
            form = UserForm(request.POST)
            if form.is_valid():
                params = [
                    form.cleaned_data['login'],
                    form.cleaned_data['password'],
                    form.cleaned_data['roleName']
                ]
                g_Cursor.callproc('UpdateUser', [pk] + params)

                return redirect('admin_user_list')
        else:
            client_cursor = g_Cursor.callfunc('GetUser', cx_Oracle.CURSOR, [pk])
            data = client_cursor.fetchall()
            if data:
                data = data[0]
            else:
                return render(request, 'dota_wiki/record_404.html', {})

            form = UserForm(initial={
                'login': data[0],
                'password': data[1],
                'roleName': data[2]
            })

        context = {'user': g_UserLogin, 'form': form, 'pk': pk}
        return render(request, 'dota_wiki/admin/user_edit.html', context)
    else:
        return render(request, 'dota_wiki/non-authorized.html', {'user': g_UserLogin})


def admin_user_remove(request, pk):
    if get_access('admin'):
        g_Cursor.callproc('DeleteUser', [pk])
        return redirect('admin_user_list')
    else:
        return render(request, 'dota_wiki/non-authorized.html', {'user': g_UserLogin})


# --------------------------------------ROLE----------------------------------------------------
def admin_role_new(request):
    if get_access('admin'):
        error = ''
        if request.method == 'POST':
            form = RoleForm(request.POST)
            if form.is_valid():
                params = [
                    form.cleaned_data['name'],
                    form.cleaned_data['priority']
                ]
                try:
                    g_Cursor.callproc('AddRole', params)
                except IntegrityError:
                    error = 'Such role is already exist'

                if not error:
                    return redirect('admin_role_list')
        else:
            form = RoleForm()

        context = {'user': g_UserLogin, 'error': error, 'form': form}
        return render(request, 'dota_wiki/admin/role_new.html', context)
    else:
        return render(request, 'dota_wiki/non-authorized.html', {'user': g_UserLogin})


def admin_role_edit(request, pk):
    if get_access('admin'):
        if request.method == 'POST':
            form = RoleForm(request.POST)
            if form.is_valid():
                params = [
                    form.cleaned_data['name'],
                    form.cleaned_data['priority']
                ]
                g_Cursor.callproc('UpdateRole', [pk] + params)

                return redirect('admin_role_list')
        else:
            client_cursor = g_Cursor.callfunc('GetRole', cx_Oracle.CURSOR, [pk])
            data = client_cursor.fetchall()
            if data:
                data = data[0]
            else:
                return render(request, 'dota_wiki/record_404.html', {})
            
            form = UserForm(initial={
                'name': data[0],
                'priority': data[1]
            })

        context = {'user': g_UserLogin, 'form': form, 'pk': pk}
        return render(request, 'dota_wiki/admin/role_edit.html', context)
    else:
        return render(request, 'dota_wiki/non-authorized.html', {'user': g_UserLogin})


def admin_role_remove(request, pk):
    if get_access('admin'):
        g_Cursor.callproc('DeleteRole', [pk])
        return redirect('admin_role_list')
    else:
        return render(request, 'dota_wiki/non-authorized.html', {'user': g_UserLogin})


# ------------------------------------------HERO------------------------------------------
def admin_hero_new(request):
    if get_access('admin'):
        if request.method == 'POST':
            form = HeroForm(request.POST)
            if form.is_valid():
                params = [
                    form.cleaned_data['name']
                ]
                g_Cursor.callproc('AddHero', params)

                return redirect('admin_hero_list')
        else:
            form = HeroForm()

        context = {'user': g_UserLogin, 'form': form}
        return render(request, 'dota_wiki/admin/hero_new.html', context)
    else:
        return render(request, 'dota_wiki/non-authorized.html', {'user': g_UserLogin})


def admin_hero_edit(request, pk):
    if get_access('admin'):
        if request.method == 'POST':
            form = HeroForm(request.POST)
            if form.is_valid():
                params = [
                    form.cleaned_data['name']
                ]
                g_Cursor.callproc('UpdateHero', [pk] + params)

                return redirect('admin_hero_list')
        else:
            client_cursor = g_Cursor.callfunc('GetHero', cx_Oracle.CURSOR, [pk])
            data = client_cursor.fetchall()
            if data:
                data = data[0]
            else:
                return render(request, 'dota_wiki/record_404.html', {})
            
            form = HeroForm(initial={
                'name': data[0]
            })

        context = {'user': g_UserLogin, 'form': form, 'pk': pk}
        return render(request, 'dota_wiki/admin/hero_edit.html', context)
    else:
        return render(request, 'dota_wiki/non-authorized.html', {'user': g_UserLogin})


def admin_hero_remove(request, pk):
    if get_access('admin'):
        g_Cursor.callproc('DeleteHero', [pk])
        return redirect('admin_hero_list')
    else:
        return render(request, 'dota_wiki/non-authorized.html', {'user': g_UserLogin})


# --------------------------------------MATCH-------------------------------------------------
def admin_match_new(request):
    if get_access('admin'):
        if request.method == 'POST':
            form = MatchForm(request.POST)
            if form.is_valid():
                params = [
                    form.cleaned_data['tournamentName'],
                    form.cleaned_data['firstTeamName'],
                    form.cleaned_data['secondTeamName'],
                    form.cleaned_data['matchDate'].strftime('%Y-%m-%d'),
                    form.cleaned_data['bracketStage'],
                    form.cleaned_data['firstTeamScore'],
                    form.cleaned_data['secondTeamScore']
                ]
                g_Cursor.callproc('AddMatch', params)

                return redirect('admin_match_list')
        else:
            form = MatchForm()

        context = {'user': g_UserLogin, 'form': form}
        return render(request, 'dota_wiki/admin/match_new.html', context)
    else:
        return render(request, 'dota_wiki/non-authorized.html', {'user': g_UserLogin})


def admin_match_edit(request, pk):
    if get_access('admin'):
        if request.method == 'POST':
            form = MatchForm(request.POST)
            if form.is_valid():
                params = [
                    form.cleaned_data['tournamentName'],
                    form.cleaned_data['firstTeamName'],
                    form.cleaned_data['secondTeamName'],
                    form.cleaned_data['matchDate'].strftime('%Y-%m-%d'),
                    form.cleaned_data['bracketStage'],
                    form.cleaned_data['firstTeamScore'],
                    form.cleaned_data['secondTeamScore']
                ]
                g_Cursor.callproc('UpdateMatch', [pk] + params)

                return redirect('admin_match_list')
        else:
            client_cursor = g_Cursor.callfunc('GetMatch', cx_Oracle.CURSOR, [pk])
            data = client_cursor.fetchall()
            if data:
                data = data[0]
            else:
                return render(request, 'dota_wiki/record_404.html', {})
            
            form = MatchForm(initial={
                'tournamentName': data[0],
                'firstTeamName': data[1],
                'secondTeamName': data[2],
                'matchDate': data[3],
                'bracketStage': data[4],
                'firstTeamScore': data[5],
                'secondTeamScore': data[6],
            })

        context = {'user': g_UserLogin, 'form': form, 'pk': pk}
        return render(request, 'dota_wiki/admin/match_edit.html', context)
    else:
        return render(request, 'dota_wiki/non-authorized.html', {'user': g_UserLogin})


def admin_match_remove(request, pk):
    if get_access('admin'):
        g_Cursor.callproc('DeleteMatch', [pk])
        return redirect('admin_match_list')
    else:
        return render(request, 'dota_wiki/non-authorized.html', {'user': g_UserLogin})


# --------------------------------SPONSOR-------------------------------------------
def admin_sponsor_new(request):
    if get_access('admin'):
        if request.method == 'POST':
            form = SponsorForm(request.POST)
            if form.is_valid():
                params = [
                    form.cleaned_data['url']
                ]
                g_Cursor.callproc('AddSponsor', params)

                return redirect('admin_sponsor_list')
        else:
            form = SponsorForm()

        context = {'user': g_UserLogin, 'form': form}
        return render(request, 'dota_wiki/admin/sponsor_new.html', context)
    else:
        return render(request, 'dota_wiki/non-authorized.html', {'user': g_UserLogin})


def admin_sponsor_edit(request, pk):
    if get_access('admin'):
        if request.method == 'POST':
            form = SponsorForm(request.POST)
            if form.is_valid():
                params = [
                    form.cleaned_data['url']
                ]
                g_Cursor.callproc('UpdateSponsor', [pk] + params)

                return redirect('admin_sponsor_list')
        else:
            client_cursor = g_Cursor.callfunc('GetSponsor', cx_Oracle.CURSOR, [pk])
            data = client_cursor.fetchall()
            if data:
                data = data[0]
            else:
                return render(request, 'dota_wiki/record_404.html', {})
            
            form = SponsorForm(initial={
                'url': data[0]
            })

        context = {'user': g_UserLogin, 'form': form, 'pk': pk}
        return render(request, 'dota_wiki/admin/sponsor_edit.html', context)
    else:
        return render(request, 'dota_wiki/non-authorized.html', {'user': g_UserLogin})


def admin_sponsor_remove(request, pk):
    if get_access('admin'):
        g_Cursor.callproc('DeleteSponsor', [pk])
        return redirect('admin_sponsor_list')
    else:
        return render(request, 'dota_wiki/non-authorized.html', {'user': g_UserLogin})


# --------------------------TOURNAMENT_WINNER------------------------------------------
def admin_tournament_winner_new(request):
    if get_access('admin'):
        if request.method == 'POST':
            form = TournamentWinnerForm(request.POST)
            if form.is_valid():
                params = [
                    form.cleaned_data['teamName'],
                    form.cleaned_data['tournamentName'],
                    form.cleaned_data['winDate'].strftime('%Y-%m-%d'),
                    form.cleaned_data['place'],
                    form.cleaned_data['usd']
                ]
                g_Cursor.callproc('AddTournamentWinner', params)

                return redirect('admin_tournament_winner_list')
        else:
            form = TournamentWinnerForm()

        context = {'user': g_UserLogin, 'form': form}
        return render(request, 'dota_wiki/admin/tournament_winner_new.html', context)
    else:
        return render(request, 'dota_wiki/non-authorized.html', {'user': g_UserLogin})


def admin_tournament_winner_edit(request, pk):
    if get_access('admin'):
        if request.method == 'POST':
            form = TournamentWinnerForm(request.POST)
            if form.is_valid():
                params = [
                    form.cleaned_data['teamName'],
                    form.cleaned_data['tournamentName'],
                    form.cleaned_data['winDate'].strftime('%Y-%m-%d'),
                    form.cleaned_data['place'],
                    form.cleaned_data['usd']
                ]
                g_Cursor.callproc('UpdateTournamentWinner', [pk] + params)

                return redirect('admin_tournament_winner_list')
        else:
            client_cursor = g_Cursor.callfunc('GetTournamentWinner', cx_Oracle.CURSOR, [pk])
            data = client_cursor.fetchall()
            if data:
                data = data[0]
            else:
                return render(request, 'dota_wiki/record_404.html', {})
            
            form = TournamentWinnerForm(initial={
                'teamName': data[0],
                'tournamentName': data[1],
                'winDate': data[2],
                'place': data[3],
                'usd': data[4]
            })

        context = {'user': g_UserLogin, 'form': form, 'pk': pk}
        return render(request, 'dota_wiki/admin/tournament_winner_edit.html', context)
    else:
        return render(request, 'dota_wiki/non-authorized.html', {'user': g_UserLogin})


def admin_tournament_winner_remove(request, pk):
    if get_access('admin'):
        g_Cursor.callproc('DeleteTournamentWinner', [pk])
        return redirect('admin_tournament_winner_list')
    else:
        return render(request, 'dota_wiki/non-authorized.html', {'user': g_UserLogin})


# -----------------------------------SIGNATURE_HERO------------------------------------------
def admin_signature_hero_new(request):
    if get_access('admin'):
        if request.method == 'POST':
            form = SignatureHeroForm(request.POST)
            if form.is_valid():
                params = [
                    form.cleaned_data['playerName'],
                    form.cleaned_data['heroName']
                ]
                g_Cursor.callproc('AddSignatureHero', params)

                return redirect('admin_signature_hero_list')
        else:
            form = SignatureHeroForm()

        context = {'user': g_UserLogin, 'form': form}
        return render(request, 'dota_wiki/admin/signature_hero_new.html', context)
    else:
        return render(request, 'dota_wiki/non-authorized.html', {'user': g_UserLogin})


def admin_signature_hero_edit(request, pk1, pk2):
    if get_access('admin'):
        if request.method == 'POST':
            form = SignatureHeroForm(request.POST)
            if form.is_valid():
                params = [
                    form.cleaned_data['playerName'],
                    form.cleaned_data['heroName']
                ]
                g_Cursor.callproc('UpdateSignatureHero', [pk1, pk2] + params)

                return redirect('admin_signature_hero_list')
        else:
            client_cursor = g_Cursor.callfunc('GetSignatureHero', cx_Oracle.CURSOR, [pk1, pk2])
            data = client_cursor.fetchall()
            if data:
                data = data[0]
            else:
                return render(request, 'dota_wiki/record_404.html', {})

            form = SignatureHeroForm(initial={
                'playerName': data[0],
                'heroName': data[1]
            })

        context = {'user': g_UserLogin, 'form': form, 'pk1': pk1, 'pk2': pk2}
        return render(request, 'dota_wiki/admin/signature_hero_edit.html', context)
    else:
        return render(request, 'dota_wiki/non-authorized.html', {'user': g_UserLogin})


def admin_signature_hero_remove(request, pk1, pk2):
    if get_access('admin'):
        g_Cursor.callproc('DeleteSignatureHero', [pk1, pk2])
        return redirect('admin_signature_hero_list')
    else:
        return render(request, 'dota_wiki/non-authorized.html', {'user': g_UserLogin})


# -----------------------------------SPONSOR_TOURNAMENT---------------------------------
def admin_sponsor_tournament_new(request):
    if get_access('admin'):
        if request.method == 'POST':
            form = SponsorTournamentForm(request.POST)
            if form.is_valid():
                params = [
                    form.cleaned_data['sponsorUrl'],
                    form.cleaned_data['tournamentName']
                ]
                g_Cursor.callproc('AddSponsorTournament', params)

                return redirect('admin_sponsor_tournament_list')
        else:
            form = SponsorTournamentForm()

        context = {'user': g_UserLogin, 'form': form}
        return render(request, 'dota_wiki/admin/sponsor_tournament_new.html', context)
    else:
        return render(request, 'dota_wiki/non-authorized.html', {'user': g_UserLogin})


def admin_sponsor_tournament_edit(request, pk1, pk2):
    if get_access('admin'):
        if request.method == 'POST':
            form = SponsorTournamentForm(request.POST)
            if form.is_valid():
                params = [
                    form.cleaned_data['sponsorUrl'],
                    form.cleaned_data['tournamentName']
                ]
                g_Cursor.callproc('UpdateSponsorTournament', [pk1, pk2] + params)

                return redirect('admin_signature_hero_list')
        else:
            client_cursor = g_Cursor.callfunc('GetSponsorTournament', cx_Oracle.CURSOR, [pk1, pk2])
            data = client_cursor.fetchall()
            if data:
                data = data[0]
            else:
                return render(request, 'dota_wiki/record_404.html', {})

            form = SponsorTournamentForm(initial={
                'sponsorUrl': data[0],
                'tournamentName': data[1]
            })

        context = {'user': g_UserLogin, 'form': form, 'pk1': pk1, 'pk2': pk2}
        return render(request, 'dota_wiki/admin/sponsor_tournament_edit.html', context)
    else:
        return render(request, 'dota_wiki/non-authorized.html', {'user': g_UserLogin})


def admin_sponsor_tournament_remove(request, pk1, pk2):
    if get_access('admin'):
        g_Cursor.callproc('DeleteSponsorTournament', [pk1, pk2])
        return redirect('admin_sponsor_tournament_list')
    else:
        return render(request, 'dota_wiki/non-authorized.html', {'user': g_UserLogin})


# ----------------------------TEAM_PLAYER----------------------------------------
def admin_team_player_new(request):
    if get_access('admin'):
        if request.method == 'POST':
            form = TeamPlayerForm(request.POST)
            if form.is_valid():
                params = [
                    form.cleaned_data['teamName'],
                    form.cleaned_data['playerName'],
                    form.cleaned_data['joinDate'].strftime('%Y-%m-%d'),
                    form.cleaned_data['leaveDate'].strftime('%Y-%m-%d')
                ]
                g_Cursor.callproc('AddTeamPlayer', params)

                return redirect('admin_team_player_list')
        else:
            form = TeamPlayerForm()

        context = {'user': g_UserLogin, 'form': form}
        return render(request, 'dota_wiki/admin/team_player_new.html', context)
    else:
        return render(request, 'dota_wiki/non-authorized.html', {'user': g_UserLogin})


def admin_team_player_edit(request, pk1, pk2):
    if get_access('admin'):
        if request.method == 'POST':
            form = TeamPlayerForm(request.POST)
            if form.is_valid():
                params = [
                    form.cleaned_data['teamName'],
                    form.cleaned_data['playerName'],
                    form.cleaned_data['joinDate'].strftime('%Y-%m-%d'),
                    form.cleaned_data['leaveDate'].strftime('%Y-%m-%d')
                ]
                g_Cursor.callproc('UpdateTeamPlayer', [pk1, pk2] + params)

                return redirect('admin_team_player_list')
        else:
            client_cursor = g_Cursor.callfunc('GetTeamPlayer', cx_Oracle.CURSOR, [pk1, pk2])
            data = client_cursor.fetchall()
            if data:
                data = data[0]
            else:
                return render(request, 'dota_wiki/record_404.html', {})
            
            form = TeamPlayerForm(initial={
                'teamName': data[0],
                'playerName': data[1],
                'joinDate': data[2],
                'leaveDate': data[3]
            })

        context = {'user': g_UserLogin, 'form': form, 'pk1': pk1, 'pk2': pk2}
        return render(request, 'dota_wiki/admin/team_player_edit.html', context)
    else:
        return render(request, 'dota_wiki/non-authorized.html', {'user': g_UserLogin})


def admin_team_player_remove(request, pk1, pk2):
    if get_access('admin'):
        g_Cursor.callproc('DeleteTeamPlayer', [pk1, pk2])
        return redirect('admin_team_player_list')
    else:
        return render(request, 'dota_wiki/non-authorized.html', {'user': g_UserLogin})


# -------------------------------TOURNAMENT_TEAM--------------------------------
def admin_tournament_team_new(request):
    if get_access('admin'):
        if request.method == 'POST':
            form = TournamentTeamForm(request.POST)
            if form.is_valid():
                params = [
                    form.cleaned_data['tournamentName'],
                    form.cleaned_data['teamName'],
                    form.cleaned_data['isInvited']
                ]
                g_Cursor.callproc('AddTournamentTeam', params)

                return redirect('admin_tournament_team_list')
        else:
            form = TournamentTeamForm()

        context = {'user': g_UserLogin, 'form': form}
        return render(request, 'dota_wiki/admin/tournament_team_new.html', context)
    else:
        return render(request, 'dota_wiki/non-authorized.html', {'user': g_UserLogin})


def admin_tournament_team_edit(request, pk1, pk2):
    if get_access('admin'):
        if request.method == 'POST':
            form = TournamentTeamForm(request.POST)
            if form.is_valid():
                params = [
                    form.cleaned_data['tournamentName'],
                    form.cleaned_data['teamName'],
                    form.cleaned_data['isInvited']
                ]
                g_Cursor.callproc('UpdateTournamentTeam', [pk1, pk2] + params)

                return redirect('admin_tournament_team_list')
        else:
            client_cursor = g_Cursor.callfunc('GetTournamentTeam', cx_Oracle.CURSOR, [pk1, pk2])
            data = client_cursor.fetchall()
            if data:
                data = data[0]
            else:
                return render(request, 'dota_wiki/record_404.html', {})
            
            form = TournamentTeamForm(initial={
                'tournamentName': data[0],
                'teamName': data[1],
                'isInvited': data[2]
            })

        context = {'user': g_UserLogin, 'form': form, 'pk1': pk1, 'pk2': pk2}
        return render(request, 'dota_wiki/admin/tournament_team_edit.html', context)
    else:
        return render(request, 'dota_wiki/non-authorized.html', {'user': g_UserLogin})


def admin_tournament_team_remove(request, pk1, pk2):
    if get_access('admin'):
        g_Cursor.callproc('DeleteTournamentTeam', [pk1, pk2])
        return redirect('admin_tournament_team_list')
    else:
        return render(request, 'dota_wiki/non-authorized.html', {'user': g_UserLogin})
