program Coloration;



uses
  Forms,
  U_Color in 'U_Color.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
