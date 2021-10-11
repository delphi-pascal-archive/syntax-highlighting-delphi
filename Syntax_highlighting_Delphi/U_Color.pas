unit U_Color;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    RichEdit1: TRichEdit;
    Btn_Colorier: TButton;
    procedure Btn_ColorierClick(Sender: TObject);
  private
    { D�clarations priv�es }
  public
    { D�clarations publiques }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
procedure HightLight_Syntax(ARE : TRichEdit);
//{$REGION 'Sub-functions'}
// Sous fonction seulement visible � l'int�rieur de HighLight_Syntax et qui a acc�s � ARE
procedure HighLight_Others(AStart, AEnd : String; AColor : TColor);
var
  iNext, iPos, iPos_End : Integer;
begin
  iNext := 0;
  iPos := ARE.FindText(AStart, iNext, Length(ARE.Text), [stMatchCase]);
  while iPos <> -1 do // FindText renvoit -1 si il n'a pas trouv� AStart dans le RichEdit
  begin
    iNext := iPos + Length(AStart); // On r�tr�cit le texte � parcourir pour ne pas boucler sur toujours le m�me mot
    ARE.SelStart := iPos; // On initialise la position de d�part du RichEdit
    iPos_End := ARE.FindText(AEnd, iNext, Length(ARE.Text), [stMatchCase]); // On cherche la position du deuxi�me caract�re qui doit arr�ter la coloration
    if iPos_End = -1 then
      if AStart = '''' then
        iPos_End := ARE.FindText(#13, iNext, Length(ARE.Text), [stMatchCase]) // Quand il s'agit d'une ouverture de chaine ('), on termine la coloration � la fin de la ligne
      else
        iPos_End := Length(ARE.Text); // Par d�faut, s'il manque le caract�re de fin, on termine la coloration � la fin du texte

    ARE.SelLength := (iPos_End  - iPos) + Length(AEnd); // On d�finit jusqu'� o� doit �tre color� le texte
    ARE.SelAttributes.Color := AColor; // Et on colore
    if AStart = '''' then
      iPos := ARE.FindText('''', iNext + iPos_End, Length(ARE.Text), [stMatchCase]) // Quand il s'agit d'une ouverture de chaine, la position de la chaine suivante doit commencer apr�s la fermeture de la derni�re chaine
    else
      iPos := ARE.FindText(AStart, iNext, Length(ARE.Text), [stMatchCase]);
  end;
end;
//{$ENDREGION}

var
  SL_Key_Word : TStringList;
  i, iPos, iNext, iPos_Symb_Start, iPos_Symb_End, iTest : Integer;
const
  C_Path = 'KeyWords.txt';
begin
  ARE.SelectAll;
  ARE.SelAttributes.Color := clBlack;
  SL_Key_Word := TStringList.Create;
  try
    SL_Key_Word.LoadFromFile(C_Path);
    i := 0;
    while i < SL_Key_Word.Count do
    begin
      iNext := 0;
      iPos := ARE.FindText(SL_Key_Word[i], iNext, Length(ARE.Text), [stWholeWord]); // On ne recherche que les mots ENTIERS qui correspondent � un mot clef
      while iPos <> -1 do
      begin
        iPos_Symb_Start := ARE.FindText('_', iPos - 1, 1, [stMatchCase]); // Pour �viter que les mots pr�c�d�s de "_" ne soient color�s aussi (FindText ne g�re pas �a)
        if iPos = 0 then
          iTest := 0 // Si la position est �gale � 0, c'est qu'il n'y a obligatoirement aucun "_" avant. Pour �viter que iPos - iPos_Symb_Start = 1.
        else
          iTest := iPos - iPos_Symb_Start;

        iPos_Symb_End := ARE.FindText('_', iPos, Length(SL_Key_Word[i]) + 1, [stMatchCase]); // Pour �viter que les mots suivis de "_" ne soient color�s aussi
        if (iTest <> 1) and (((Length(SL_Key_Word[i]) + iPos) - iPos_Symb_End) + 1 <> 1) then // Si le mot n'est pas entour� de "_"
        begin
          iNext := iPos + Length(SL_Key_Word[i]); // La prochaine recherche se fait � partir de la fin du dernier mot clef trouv�
          ARE.SelStart := iPos;
          ARE.SelLength := Length(SL_Key_Word[i]);
          ARE.SelAttributes.Color := clNavy;
        end
        else
          iNext := iPos + Length(SL_Key_Word[i]) - 1; // Ici ce n'est pas un mot clef

        iPos := ARE.FindText(SL_Key_Word[i], iNext, Length(ARE.Text), [stWholeWord]); // Recherche du prochain mot clef
      end;
      inc(i);
    end;

    HighLight_Others('(*', '*)', clGreen);
    HighLight_Others('//', #13, clGreen); // #13 repr�sente le saut de ligne
    HighLight_Others('{', '}', clGreen);
    HighLight_Others('{$', '}', clTeal);
    HighLight_Others('''', '''', clBlue);
  finally
    SL_Key_Word.Free;
  end;
end;

procedure TForm1.Btn_ColorierClick(Sender: TObject);
begin
  HightLight_Syntax(RichEdit1);
end;

end.
