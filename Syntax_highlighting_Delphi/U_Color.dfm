object Form1: TForm1
  Left = 236
  Top = 116
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Syntax highlighting'
  ClientHeight = 578
  ClientWidth = 472
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object RichEdit1: TRichEdit
    Left = 0
    Top = 0
    Width = 472
    Height = 578
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Lines.Strings = (
      'unit U_Color;'
      ''
      'interface'
      ''
      'uses'
      
        '  Windows, Messages, SysUtils, Variants, Classes, Graphics, Cont' +
        'rols, Forms,'
      '  Dialogs, StdCtrls, ComCtrls;'
      ''
      'type'
      '  TForm1 = class(TForm)'
      '    RichEdit1: TRichEdit;'
      '    Btn_Colorier: TButton;'
      '    procedure Btn_ColorierClick(Sender: TObject);'
      '  private'
      '    { Declarations privees }'
      '  public'
      '    { Declarations publiques }'
      '  end;'
      ''
      'var'
      '  Form1: TForm1;'
      ''
      'implementation'
      '{$R *.dfm}'
      'procedure test ();'
      'begin'
      '  // Commentaire sur une ligne'
      '  (* commentaire'
      '  sur'
      '  plusieurs'
      '  lignes *)'
      ''
      '  { Autre'
      '  commentaire'
      '  sur'
      '  plusieurs'
      '  lignes }'
      'end;'
      ''
      'end.')
    ParentFont = False
    TabOrder = 0
  end
  object Btn_Colorier: TButton
    Left = 16
    Top = 536
    Width = 441
    Height = 25
    Caption = 'Highlight!'
    TabOrder = 1
    OnClick = Btn_ColorierClick
  end
end
