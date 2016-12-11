from django import forms


class LoginForm(forms.Form):
    login = forms.CharField(64)
    password = forms.CharField(64, widget=forms.PasswordInput)


class RegisterForm(forms.Form):
    login = forms.CharField(64)
    password = forms.CharField(64, widget=forms.PasswordInput)
    passwordConfirm = forms.CharField(64, label='Confirm Password', widget=forms.PasswordInput)


class TeamForm(forms.Form):
    name = forms.CharField(30)
    captainName = forms.CharField(30, label='Captain Name')
    location = forms.CharField(30)
    coachName = forms.CharField(30, label='Coach Name', required=False)


class PlayerForm(forms.Form):
    nickName = forms.CharField(30, label='Nick Name')
    position = forms.IntegerField()
    firstName = forms.CharField(20)
    lastName = forms.CharField(20)
    country = forms.CharField(20)


class TournamentForm(forms.Form):
    name = forms.CharField(70)
    type = forms.CharField(20)
    format = forms.CharField(200)
    prizePool = forms.IntegerField(label='Prize Pool')
    startDate = forms.DateField(input_formats=('%Y-%m-%d',), label='Start Date')
    endDate = forms.DateField(input_formats=('%Y-%m-%d',), label='End Date')
    gameVersion = forms.CharField(10, label='Game Version')


class UserForm(forms.Form):
    login = forms.CharField(64)
    password = forms.CharField(64)
    roleName = forms.CharField(40, label='Role Name')


class RoleForm(forms.Form):
    name = forms.CharField(40)
    priority = forms.IntegerField()


class HeroForm(forms.Form):
    name = forms.CharField(45)


class MatchForm(forms.Form):
    tournamentName = forms.CharField(70, label='Tournament Name')
    firstTeamName = forms.CharField(30, label='First Team Name')
    secondTeamName = forms.CharField(30, label='Second Team Name')
    matchDate = forms.DateField(input_formats=('%Y-%m-%d',))
    bracketStage = forms.CharField(40, label='Bracket Stage')
    firstTeamScore = forms.IntegerField(label='First Team Score')
    secondTeamScore = forms.IntegerField(label='Second Team Score')


class SponsorForm(forms.Form):
    url = forms.URLField(label='URL')


class TournamentWinnerForm(forms.Form):
    teamName = forms.CharField(30, label='Team Name')
    tournamentName = forms.CharField(70, label='Tournament Name')
    winDate = forms.DateField(input_formats=('%Y-%m-%d',), label='Date')
    place = forms.IntegerField()
    usd = forms.IntegerField()


class SignatureHeroForm(forms.Form):
    playerName = forms.CharField(30, label='Player Nick Name')
    heroName = forms.CharField(45, label='Hero Name')


class SponsorTournamentForm(forms.Form):
    sponsorUrl = forms.EmailField(label='Sponsor URL')
    tournamentName = forms.CharField(70, label='Tournament Name')


class TeamPlayerForm(forms.Form):
    teamName = forms.CharField(30, label='Team Name')
    playerName = forms.CharField(30, label='Player Name')
    joinDate = forms.DateField(input_formats=('%Y-%m-%d',), label='Join Date')
    leaveDate = forms.DateField(input_formats=('%Y-%m-%d',), label='Leave Date', initial='9999-12-01')


class TournamentTeamForm(forms.Form):
    tournamentName = forms.CharField(70, label='Tournament Name')
    teamName = forms.CharField(30, label='Team Name')
    isInvited = forms.BooleanField(label='Is Invited')


