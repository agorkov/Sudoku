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
    btnSave: TButton;
    btnLoad: TButton;
    procedure btn_new_fieldClick(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnLoadClick(Sender: TObject);
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
  ii: Integer;
  jj: Integer;
  v: TEVal;
  sv: set of TEVal;
  si, sj: byte;
  cnt: byte;
  fl: boolean;
begin
  for i := 1 to FIELD_SIZE do
    for j := 1 to FIELD_SIZE do
      VCL_field[i, j].Font.Color := clBlack;

  //Выбираем единственную возможную цифру
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
  //Ищем по блокам единственные клетки
  for si := 1 to 3 do
    for sj := 1 to 3 do
      for v := TEVal(1) to TEVal(9) do
      begin
        cnt := 0;
        for i := (si - 1) * 3 + 1 to (si - 1) * 3 + 3 do
          for j := (sj - 1) * 3 + 1 to (sj - 1) * 3 + 3 do
            if v in field[i, j].possible_values then
              cnt := cnt + 1;
        if cnt = 1 then
        begin
          for i := (si - 1) * 3 + 1 to (si - 1) * 3 + 3 do
            for j := (sj - 1) * 3 + 1 to (sj - 1) * 3 + 3 do
              if v in field[i, j].possible_values then
              begin
                VCL_field[i, j].Text := IntToStr(Ord(v));
                VCL_field[i, j].Font.Color := clRed;
                Edit1Change(vcl_field[i, j]);
                Exit;
              end;
        end;
      end;
  //Ищем по строкам единственные возможные размещения
  for i := 1 to FIELD_SIZE do
  begin
    for v := TEVal(1) to TEVal(9) do
    begin
      cnt := 0;
      for j := 1 to FIELD_SIZE do
        if v in field[i, j].possible_values then
          cnt := cnt + 1;
      if cnt = 1 then
      begin
        for j := 1 to FIELD_SIZE do
          if v in field[i, j].possible_values then
          begin
            VCL_field[i, j].Text := IntToStr(Ord(v));
            VCL_field[i, j].Font.Color := clRed;
            Edit1Change(vcl_field[i, j]);
            Exit;
          end;
      end;
    end;
  end;
  //Ищем по столбцам единственные возможные размещения
  for j := 1 to FIELD_SIZE do
  begin
    for v := TEVal(1) to TEVal(9) do
    begin
      cnt := 0;
      for i := 1 to FIELD_SIZE do
        if v in field[i, j].possible_values then
          cnt := cnt + 1;
      if cnt = 1 then
      begin
        for i := 1 to FIELD_SIZE do
          if v in field[i, j].possible_values then
          begin
            VCL_field[i, j].Text := IntToStr(Ord(v));
            VCL_field[i, j].Font.Color := clRed;
            Edit1Change(vcl_field[i, j]);
            Exit;
          end;
      end;
    end;
  end;
  // Ищем двойки в секторах
  for si := 1 to 3 do
  begin
    for sj := 1 to 3 do
    begin
      for i := (si - 1) * 3 + 1 to (si - 1) * 3 + 3 do
      begin
        for j := (sj - 1) * 3 + 1 to (sj - 1) * 3 + 3 do
        begin
          // Считаем количество возможных элементов
          cnt := 0;
          for v := TEVal(1) to TEVal(9) do
            if v in field[i, j].possible_values then
              cnt := cnt + 1;
          if cnt = 2 then
          begin
            cnt := 0;
            sv := field[i, j].possible_values;
            for ii := (si - 1) * 3 + 1 to (si - 1) * 3 + 3 do
            begin
              for jj := (sj - 1) * 3 + 1 to (sj - 1) * 3 + 3 do
              begin
                if (field[ii, jj].possible_values = sv) then
                  cnt := cnt + 1;
              end
            end;

            if cnt = 2 then
            begin
              fl := False;
              for ii := (si - 1) * 3 + 1 to (si - 1) * 3 + 3 do
              begin
                for jj := (sj - 1) * 3 + 1 to (sj - 1) * 3 + 3 do
                begin
                  if field[ii, jj].possible_values <> sv then
                  begin
                    if field[ii, jj].possible_values * sv <> [] then
                      fl := true;
                    field[ii, jj].possible_values := field[ii, jj].possible_values - sv;
                  end;
                end;
              end;
              if fl then
              begin
                btnHelpClick(nil);
                Exit;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
  // Ищем двойки в строках
  for i := 1 to FIELD_SIZE do
    for j := 1 to FIELD_SIZE do
    begin
    // Считаем количество возможных элементов
      cnt := 0;
      for v := TEVal(1) to TEVal(9) do
        if v in field[i, j].possible_values then
          cnt := cnt + 1;
      if cnt = 2 then
      begin
        cnt := 0;
        sv := field[i, j].possible_values;

        for jj := 1 to FIELD_SIZE do
        begin
          if (field[i, jj].possible_values = sv) then
            cnt := cnt + 1;
        end;

        if cnt = 2 then
        begin
          fl := False;
          for jj := 1 to FIELD_SIZE do
          begin
            if field[i, jj].possible_values <> sv then
            begin
              if field[i, jj].possible_values * sv <> [] then
                fl := true;
              field[i, jj].possible_values := field[i, jj].possible_values - sv;
            end;
          end;
        end;
        if fl then
        begin
          btnHelpClick(nil);
          Exit;
        end;
      end;
    end;

    // Ищем двойки в столбцах
  for j := 1 to FIELD_SIZE do
    for i := 1 to FIELD_SIZE do
    begin
    // Считаем количество возможных элементов
      cnt := 0;
      for v := TEVal(1) to TEVal(9) do
        if v in field[i, j].possible_values then
          cnt := cnt + 1;
      if cnt = 2 then
      begin
        cnt := 0;
        sv := field[i, j].possible_values;

        for ii := 1 to FIELD_SIZE do
        begin
          if (field[ii, j].possible_values = sv) then
            cnt := cnt + 1;
        end;

        if cnt = 2 then
        begin
          fl := False;
          for ii := 1 to FIELD_SIZE do
          begin
            if field[ii, j].possible_values <> sv then
            begin
              if field[ii, j].possible_values * sv <> [] then
                fl := true;
              field[ii, j].possible_values := field[ii, j].possible_values - sv;
            end;
          end;
        end;
        if fl then
        begin
          btnHelpClick(nil);
          Exit;
        end;
      end;
    end;
  ShowMessage('Нет вариантов!');
end;

procedure TForm1.btnLoadClick(Sender: TObject);
var
  f: TextFile;
  i, j: Byte;
  c: char;
begin
  AssignFile(f, 'tmp.txt');
  Reset(f);
  for i := 1 to FIELD_SIZE do
  begin
    for j := 1 to FIELD_SIZE do
    begin
      read(f, c);
      if c <> ' ' then
        VCL_field[i, j].Text := c
      else
        VCL_field[i, j].Text := '';
    end;
    Readln(f);
  end;
  CloseFile(f);
end;

procedure TForm1.btnSaveClick(Sender: TObject);
var
  f: TextFile;
  i, j: byte;
begin
  AssignFile(f, 'tmp.txt');
  Rewrite(f);
  for i := 1 to FIELD_SIZE do
  begin
    for j := 1 to FIELD_SIZE do
      if VCL_field[i, j].Text <> '' then
        write(f, VCL_field[i, j].Text)
      else
        write(f, ' ');
    Writeln(f);
  end;
  CloseFile(f);
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
  if (c_j = 0) or (c_j = 10) then
  begin
    c_i := c_i - 1;
    c_j := 9;
  end;
  if (c_i = 0) or (c_i = 10) then
    c_i := 9;

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
  //btnHelpClick(nil);
end;

end.

