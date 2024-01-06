unit UFMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    btn_new_field: TButton;
    procedure btn_new_fieldClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

const
  FIELD_SIZE = 9;

var
  VCL_field: array[1..FIELD_SIZE, 1..FIELD_SIZE] of TEdit;

procedure TForm1.btn_new_fieldClick(Sender: TObject);
var
  i, j: Byte;
begin
  for i := 1 to FIELD_SIZE do
    for j := 1 to FIELD_SIZE do
    begin
      try
        VCL_field[i, j].Free;
      finally

      end;
    end;
  for i := 1 to FIELD_SIZE do
    for j := 1 to FIELD_SIZE do
    begin
      try
        VCL_field[i, j] := TEdit.Create(nil);
        VCL_field[i, j].Parent := Form1;
        VCL_field[i, j].Height := 33;
        VCL_field[i, j].Width := 33;

        VCL_field[i, j].top := 5 + (i - 1) * 33 + 5 * (i - 1);
        VCL_field[i, j].Left := 5 + (j - 1) * 33 + 5 * (j - 1);

        VCL_field[i, j].Tag := FIELD_SIZE * (i - 1) + j;

        VCL_field[i, j].Font.Size := 16;
        VCL_field[i, j].Alignment := taCenter;
        VCL_field[i, j].Text := '0';

        VCL_field[i, j].Visible := True;
      finally

      end;
    end;
end;

end.

