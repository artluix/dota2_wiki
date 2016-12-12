from django import forms


def make_choices(candidates):
        return [(c[0], c[0]) for c in candidates]


class LoginForm(forms.Form):
    login = forms.CharField(64)
    password = forms.CharField(64, widget=forms.PasswordInput)


class RegisterForm(forms.Form):
    login = forms.CharField(64)
    password = forms.CharField(64, widget=forms.PasswordInput)
    passwordConfirm = forms.CharField(64, label='Confirm Password', widget=forms.PasswordInput)


class TeamForm(forms.Form):
    name = forms.CharField(30)
    captainName = forms.ChoiceField(label='Captain Name')
    location = forms.CharField(30)
    coachName = forms.ChoiceField(label='Coach Name', choices=[('', 'None')], initial='', required=False)

    def __init__(self, captainCandidates=None, coachCandidates=None, *args, **kwargs):
        super(TeamForm, self).__init__(*args, **kwargs)
        if captainCandidates:
            self.fields['captainName'].choices = make_choices(captainCandidates)
        if coachCandidates:
            self.fields['coachName'].choices += make_choices(coachCandidates)


class PlayerForm(forms.Form):
    nickName = forms.CharField(30, label='Nick Name')
    position = forms.IntegerField(min_value=1, max_value=6)
    firstName = forms.CharField(20)
    lastName = forms.CharField(20)
    country = forms.CharField(20)


class TournamentForm(forms.Form):
    name = forms.CharField(70)
    type = forms.CharField(20)
    format = forms.CharField(200)
    prizePool = forms.IntegerField(label='Prize Pool', min_value=0)
    startDate = forms.DateField(input_formats=('%Y-%m-%d',), label='Start Date')
    endDate = forms.DateField(input_formats=('%Y-%m-%d',), label='End Date')
    gameVersion = forms.CharField(10, label='Game Version')


class UserForm(forms.Form):
    login = forms.CharField(64)
    password = forms.CharField(64)
    roleName = forms.ChoiceField(label='Role Name')

    def __init__(self, roleCandidates=None, *args, **kwargs):
        super(UserForm, self).__init__(*args, **kwargs)
        if roleCandidates:
            self.fields['roleName'].choices = make_choices(roleCandidates)


class RoleForm(forms.Form):
    name = forms.CharField(40)
    priority = forms.IntegerField(min_value=1)


class HeroForm(forms.Form):
    name = forms.CharField(45)


class MatchForm(forms.Form):
    tournamentName = forms.ChoiceField(label='Tournament Name')
    firstTeamName = forms.ChoiceField(label='First Team Name')
    secondTeamName = forms.ChoiceField(label='Second Team Name')
    matchDate = forms.DateField(input_formats=('%Y-%m-%d',))
    bracketStage = forms.CharField(40, label='Bracket Stage')
    firstTeamScore = forms.IntegerField(label='First Team Score', min_value=0)
    secondTeamScore = forms.IntegerField(label='Second Team Score', min_value=0)

    def __init__(self, tournamentCandidates=None, teamCandidates=None, *args, **kwargs):
        super(MatchForm, self).__init__(*args, **kwargs)
        if tournamentCandidates:
            self.fields['tournamentName'].choices = make_choices(tournamentCandidates)
        if teamCandidates:
            self.fields['firstTeamName'].choices = make_choices(teamCandidates)
            self.fields['secondTeamName'].choices = make_choices(teamCandidates)


class SponsorForm(forms.Form):
    url = forms.URLField(label='URL')


class TournamentWinnerForm(forms.Form):
    teamName = forms.ChoiceField(label='Team Name')
    tournamentName = forms.ChoiceField(label='Tournament Name')
    winDate = forms.DateField(input_formats=('%Y-%m-%d',), label='Date')
    place = forms.IntegerField(min_value=1)
    usd = forms.IntegerField(min_value=0)

    def __init__(self, teamCandidates=None, tournamentCandidates=None, *args, **kwargs):
        super(TournamentWinnerForm, self).__init__(*args, **kwargs)
        if teamCandidates:
            self.fields['teamName'].choices = make_choices(teamCandidates)
        if tournamentCandidates:
            self.fields['tournamentName'].choices = make_choices(tournamentCandidates)


class SignatureHeroForm(forms.Form):
    playerName = forms.ChoiceField(label='Player Nick Name')
    heroName = forms.ChoiceField(label='Hero Name')

    def __init__(self, playerCandidates=None, heroCandidates=None, *args, **kwargs):
        super(SignatureHeroForm, self).__init__(*args, **kwargs)
        if playerCandidates:
            self.fields['playerName'].choices = make_choices(playerCandidates)
        if heroCandidates:
            self.fields['heroName'].choices = make_choices(heroCandidates)


class SponsorTournamentForm(forms.Form):
    sponsorUrl = forms.ChoiceField(label='Sponsor URL')
    tournamentName = forms.ChoiceField(label='Tournament Name')

    def __init__(self, sponsorCandidates=None, tournamentCandidates=None, *args, **kwargs):
        super(SponsorTournamentForm, self).__init__(*args, **kwargs)
        if sponsorCandidates:
            self.fields['sponsorUrl'].choices = make_choices(sponsorCandidates)
        if tournamentCandidates:
            self.fields['tournamentName'].choices = make_choices(tournamentCandidates)


class TeamPlayerForm(forms.Form):
    teamName = forms.ChoiceField(label='Team Name')
    playerName = forms.ChoiceField(label='Player Name')
    joinDate = forms.DateField(input_formats=('%Y-%m-%d',), label='Join Date')
    leaveDate = forms.DateField(input_formats=('%Y-%m-%d',), label='Leave Date', initial='9999-12-01')

    def __init__(self, teamCandidates=None, playerCandidates=None, *args, **kwargs):
        super(TeamPlayerForm, self).__init__(*args, **kwargs)
        if teamCandidates:
            self.fields['teamName'].choices = make_choices(teamCandidates)
        if playerCandidates:
            self.fields['playerName'].choices = make_choices(playerCandidates)


class TournamentTeamForm(forms.Form):
    tournamentName = forms.ChoiceField(label='Tournament Name')
    teamName = forms.ChoiceField(label='Team Name')
    isInvited = forms.BooleanField(label='Is Invited')

    def __init__(self, tournamentCandidates=None, teamCandidates=None, *args, **kwargs):
        super(TournamentTeamForm, self).__init__(*args, **kwargs)
        if tournamentCandidates:
            self.fields['tournamentName'].choices = make_choices(tournamentCandidates)
        if teamCandidates:
            self.fields['teamName'].choices = make_choices(teamCandidates)


