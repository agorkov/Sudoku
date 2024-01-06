unit UFMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    btn_new_field: TButton;
    Edit1: TEdit;
    btnHelp: TButton;
    procedure btn_new_fieldClick(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
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

type
  TEVal = (one = 1, two = 2, three = 3, four = 4, five = 5, six = 6, seven = 7, eight = 8, nine = 9);

  TRCell = record
    value: integer;
    possible_values: set of TEVal;
  end;

var
  VCL_field: array[1..FIELD_SIZE, 1..FIELD_SIZE] of TEdit;
  field: array[1..FIELD_SIZE, 1..FIELD_SIZE] of TRCell;

procedure TForm1.btnHelpClick(Sender: TObject);
var
  i: Integer;
  j: Integer;
  v: TEVal;
begin
  for i := 1 to FIELD_SIZE do
    for j := 1 to FIELD_SIZE do
      VCL_field[i, j].Font.Color := clBlack;

  for i := 1 to FIELD_SIZE do
    for j := 1 to FIELD_SIZE do
      for v := TEVal(1) to TEVal(9) do
        if field[i, j].possible_values = [v] then
        begin
          VCL_field[i, j].Text := IntToStr(Ord(v));
          VCL_field[i, j].Font.Color := clRed;
          Edit1Change(vcl_field[i, j]);
          Exit;
        end;
end;

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
        field[i, j].value := 0;
        field[i, j].possible_values := [one, two, three, four, five, six, seven, eight, nine];

        VCL_field[i, j] := TEdit.Create(nil);
        VCL_field[i, j].Parent := Form1;
        VCL_field[i, j].Height := 33;
        VCL_field[i, j].Width := 33;

        VCL_field[i, j].top := 5 + (i - 1) * 33 + 5 * (i - 1);
        VCL_field[i, j].Left := 5 + (j - 1) * 33 + 5 * (j - 1);

        VCL_field[i, j].Tag := FIELD_SIZE * i + j;

        VCL_field[i, j].Font.Size := 16;
        VCL_field[i, j].Alignment := taCenter;
        VCL_field[i, j].Text := '';

        VCL_field[i, j].Visible := True;

        VCL_field[i, j].OnChange := Edit1Change;
      finally

      end;
    end;
end;

procedure TForm1.Edit1Change(Sender: TObject);
var
  txt: string;
  c_i, c_j: byte;
  c_val: TEVal;
  i, j: Integer;
  sfi, sti, sfj, stj: byte;
begin
  c_i := (Sender as TEdit).Tag div FIELD_SIZE;
  c_j := (Sender as TEdit).Tag mod FIELD_SIZE;
  if (c_i = 0) or (c_i = 10) then
    c_i := 9;
  if (c_j = 0) or (c_j = 10) then
  begin
    c_i := c_i - 1;
    c_j := 9;
  end;
  txt := (Sender as TEdit).Text;
  if txt <> '' then
  begin
    c_val := TEVal(StrToInt(txt));

    field[c_i, c_j].value := Ord(c_val);
    field[c_i, c_j].possible_values := [c_val];

    // Удаляем из строки
    for j := 1 to FIELD_SIZE do
      Exclude(field[c_i, j].possible_values, c_val);
    // Удаляем из столбца
    for i := 1 to FIELD_SIZE do
      Exclude(field[i, c_j].possible_values, c_val);
    // Удаляем из маленького квадратика
    sfi := ((c_i - 1) div 3) * 3 + 1;
    sti := sfi + 3 - 1;
    sfj := ((c_j - 1) div 3) * 3 + 1;
    stj := sfj + 3 - 1;
    for i := sfi to sti do
      for j := sfj to stj do
        Exclude(field[i, j].possible_values, c_val);
  end
  else
  begin
    for i := 1 to FIELD_SIZE do
      for j := 1 to FIELD_SIZE do
      begin
        field[i, j].value := 0;
        field[i, j].possible_values := [one, two, three, four, five, six, seven, eight, nine];
      end;
    for i := 1 to FIELD_SIZE do
      for j := 1 to FIELD_SIZE do
        if VCL_field[i, j].Text <> '' then
          Edit1Change(VCL_field[i, j]);
  end;
end;

end.

