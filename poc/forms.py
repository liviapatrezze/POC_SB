from django import forms

from .models import Sprint


class EntregaForm(forms.Form):
    sprint = forms.ModelChoiceField(
        queryset=Sprint.objects.all().order_by("start_date"),
        widget=forms.HiddenInput(),
    )
    title = forms.CharField(
        label="Título",
        max_length=255,
        widget=forms.TextInput(attrs={"class": "cadastro-wire-input"}),
    )
    description = forms.CharField(
        label="Descrição",
        required=False,
        widget=forms.TextInput(attrs={"class": "cadastro-wire-input"}),
    )
    squad_nome = forms.CharField(
        label="Squad",
        max_length=45,
        widget=forms.TextInput(
            attrs={
                "class": "cadastro-wire-input",
                "placeholder": "Nome da squad",
                "autocomplete": "off",
            },
        ),
    )
    entrega_data = forms.DateField(
        label="Data",
        required=False,
        widget=forms.DateInput(
            attrs={"type": "date", "class": "cadastro-wire-input"},
        ),
    )
    image = forms.FileField(
        label="Enviar imagem",
        required=False,
        widget=forms.FileInput(
            attrs={
                "class": "cadastro-wire-file-native",
                "accept": "image/*,.png,.jpg,.jpeg,.gif,.webp",
            },
        ),
    )

    def clean_squad_nome(self):
        raw = self.cleaned_data.get("squad_nome", "")
        nome = raw.strip()
        if not nome:
            raise forms.ValidationError("Informe o nome da squad.")
        return nome[:45]
