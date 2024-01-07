unit UFMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    btn_new_field: TButton;
    btnHelp: TButton;
    btnSave: TButton;
    btnLoad: TButton;
    btnpossible_values: TButton;
    procedure btn_new_fieldClick(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnLoadClick(Sender: TObject);
    procedure btnpossible_valuesClick(Sender: TObject);
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

  TAField = array[1..FIELD_SIZE, 1..FIELD_SIZE] of TRCell;

var
  VCL_field: array[1..FIELD_SIZE, 1..FIELD_SIZE] of TEdit;
  field: TAField;

procedure TForm1.btnHelpClick(Sender: TObject);

  procedure OnlyOneValueInCell(const f: TAField; var ri, rj, rv: byte);
  var
    i, j: Byte;
    v: TEVal;
  begin
    ri := 0;
    rj := 0;
    rv := 0;
    for i := 1 to FIELD_SIZE do
    begin
      for j := 1 to FIELD_SIZE do
      begin
        for v := TEVal(1) to TEVal(9) do
        begin
          if field[i, j].possible_values = [v] then
          begin
            ri := i;
            rj := j;
            rv := Ord(v);
            Exit;
          end;
        end;
      end;
    end;
  end;

  procedure OnlyOneCellInBlock(const f: TAField; var ri, rj, rv: byte);
  var
    i, j: Byte;
    v: TEVal;
    si, sj: Byte;
    cnt: Byte;
  begin
    ri := 0;
    rj := 0;
    rv := 0;
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
                  ri := i;
                  rj := j;
                  rv := Ord(v);
                  Exit;
                end;
          end;
        end;
  end;

  procedure OnlyOneCellInRow(const f: TAField; var ri, rj, rv: byte);
  var
    i, j: Byte;
    v: TEVal;
    si, sj: Byte;
    cnt: Byte;
  begin
    ri := 0;
    rj := 0;
    rv := 0;
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
              ri := i;
              rj := j;
              rv := Ord(v);
              Exit;
            end;
        end;
      end;
    end;
  end;

  procedure OnlyOneCellInCol(const f: TAField; var ri, rj, rv: byte);
  var
    i, j: Byte;
    v: TEVal;
    si, sj: Byte;
    cnt: Byte;
  begin
    ri := 0;
    rj := 0;
    rv := 0;
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
              ri := i;
              rj := j;
              rv := Ord(v);
              Exit;
            end;
        end;
      end;
    end;
  end;

  procedure PairInBlock(var f: TAField; var fl: boolean);
  var
    i, j: Byte;
    ii, jj: Byte;
    v: TEVal;
    sv: set of TEVal;
    si, sj: Byte;
    cnt: Byte;
  begin
    fl := False;
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
                  exit;
              end;
            end;
          end;
        end;
      end;
    end;
  end;

  procedure PairInRow(var f: TAField; var fl: boolean);
  var
    i, j: Byte;
    ii, jj: Byte;
    v: TEVal;
    sv: set of TEVal;
    si, sj: Byte;
    cnt: Byte;
  begin
    fl := False;
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
            Exit;
        end;
      end;
  end;

  procedure PairInCol(var f: TAField; var fl: boolean);
  var
    i, j: Byte;
    ii, jj: Byte;
    v: TEVal;
    sv: set of TEVal;
    si, sj: Byte;
    cnt: Byte;
  begin
    fl := False;
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
            Exit;
        end;
      end;
  end;

  procedure SecretPairInBlock(var f: TAField; var fl: boolean);
  var
    i, j: Byte;
    ii, jj: Byte;
    v, v1, v2: TEVal;
    sv, s: set of TEVal;
    si, sj: Byte;
    ca, co: Byte;
    tf: TAField;
  begin
    fl := false;
    for v1 := TEVal(1) to TEVal(8) do
    begin
      for v2 := TEVal(Ord(v1) + 1) to TEVal(9) do
      begin
        ca := 0;
        co := 0;
        for i := (si - 1) * 3 + 1 to (si - 1) * 3 + 3 do
        begin
          for j := (sj - 1) * 3 + 1 to (sj - 1) * 3 + 3 do
          begin
            if (v1 in f[i, j].possible_values) and (v2 in f[i, j].possible_values) then
              ca := ca + 1;
            if (v1 in f[i, j].possible_values) or (v2 in f[i, j].possible_values) then
              co := co + 1;
          end;
        end;
        if (ca = 2) and (co = 2) then
        begin
          for i := (si - 1) * 3 + 1 to (si - 1) * 3 + 3 do
          begin
            for j := (sj - 1) * 3 + 1 to (sj - 1) * 3 + 3 do
            begin
              if (v1 in f[i, j].possible_values) and (v2 in f[i, j].possible_values) then
                if field[i, j].possible_values - [v1, v2] <> [] then
                begin
                  f[i, j].possible_values := [v1, v2];
                  fl := true;
                end;
            end;
          end;
          if fl then
            Exit;
        end;
      end;
    end;
  end;

  procedure SecretPairInRow(var f: TAField; var fl: boolean);
  var
    i, j: Byte;
    ii, jj: Byte;
    v1, v2: TEVal;
    sv: set of TEVal;
    si, sj: Byte;
    ca, co: Byte;
    tf: TAField;
  begin
    fl := false;
    for v1 := TEVal(1) to TEVal(8) do
    begin
      for v2 := TEVal(Ord(v1) + 1) to TEVal(9) do
      begin
        for i := 1 to FIELD_SIZE do
        begin
          ca := 0;
          co := 0;
          for j := 1 to FIELD_SIZE do
          begin
            if (v1 in f[i, j].possible_values) and (v2 in f[i, j].possible_values) then
              ca := ca + 1;
            if (v1 in f[i, j].possible_values) or (v2 in f[i, j].possible_values) then
              co := co + 1;
          end;
          if (ca = 2) and (co = 2) then
          begin
            for j := 1 to FIELD_SIZE do
            begin
              if (v1 in f[i, j].possible_values) and (v2 in f[i, j].possible_values) then
                if f[i, j].possible_values - [v1, v2] <> [] then
                begin
                  f[i, j].possible_values := [v1, v2];
                  fl := true;
                end;
            end;
            if fl then
              Exit;
          end;
        end;
      end;
    end;
  end;

  procedure SecretPairInCol(var f: TAField; var fl: boolean);
  var
    i, j: Byte;
    ii, jj: Byte;
    v1, v2: TEVal;
    sv: set of TEVal;
    si, sj: Byte;
    ca, co: Byte;
    tf: TAField;
  begin
    fl := false;
    for v1 := TEVal(1) to TEVal(8) do
    begin
      for v2 := TEVal(Ord(v1) + 1) to TEVal(9) do
      begin
        for j := 1 to FIELD_SIZE do
        begin
          ca := 0;
          co := 0;
          for i := 1 to FIELD_SIZE do
          begin
            if (v1 in f[i, j].possible_values) and (v2 in f[i, j].possible_values) then
              ca := ca + 1;
            if (v1 in f[i, j].possible_values) or (v2 in f[i, j].possible_values) then
              co := co + 1;
          end;
          if (ca = 2) and (co = 2) then
          begin
            for i := 1 to FIELD_SIZE do
            begin
              if (v1 in f[i, j].possible_values) and (v2 in f[i, j].possible_values) then
                if f[i, j].possible_values - [v1, v2] <> [] then
                begin
                  f[i, j].possible_values := [v1, v2];
                  fl := true
                end;
            end;
            if fl then
              Exit;
          end;
        end;
      end;
    end;
  end;

  procedure AllValuesInBlockInOneRowOrCol(var f: TAField; var fl: boolean);
  var
    i, j, k: Byte;
    ii, jj: Byte;
    v: TEVal;
    r, c: set of byte;
    sv, s: set of TEVal;
    si, sj: Byte;
    tf: TAField;
  begin
    fl := false;

    for v := TEVal(1) to TEVal(8) do
    begin
      for si := 1 to 3 do
        for sj := 1 to 3 do
        begin
          r := [];
          c := [];
          for i := (si - 1) * 3 + 1 to (si - 1) * 3 + 3 do
          begin
            for j := (sj - 1) * 3 + 1 to (sj - 1) * 3 + 3 do
            begin
              if v in f[i, j].possible_values then
              begin
                r := r + [i];
                c := c + [j];
              end;
            end;
          end;

          for k := 1 to 9 do
          begin
            if [k] = r then
            begin
              for j := 1 to FIELD_SIZE do
              begin
                if (j < (sj - 1) * 3 + 1) or (j > (sj - 1) * 3 + 3) then
                begin
                  if v in f[k, j].possible_values then
                  begin
                    f[k, j].possible_values := f[k, j].possible_values - [v];
                    fl := True;
                  end;
                end;
              end;
            end;
            if [k] = c then
            begin
              for i := 1 to FIELD_SIZE do
              begin
                if (i < (si - 1) * 3 + 1) or (i > (si - 1) * 3 + 3) then
                begin
                  if v in f[i, k].possible_values then
                  begin
                    f[i, k].possible_values := f[i, k].possible_values - [v];
                    fl := True;
                  end;
                end;
              end;
            end;
          end;

          if fl then
            Exit;
        end;
    end;
  end;

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
  ri, rj, rv: Byte;
begin
  for i := 1 to FIELD_SIZE do
    for j := 1 to FIELD_SIZE do
      VCL_field[i, j].Font.Color := clBlack;

  //Выбираем единственную возможную цифру
  OnlyOneValueInCell(field, ri, rj, rv);
  if (ri <> 0) and (rj <> 0) and (rv <> 0) then
  begin
    VCL_field[ri, rj].Text := IntToStr(Ord(rv));
    VCL_field[ri, rj].Font.Color := clRed;
    Edit1Change(vcl_field[ri, rj]);
    Exit;
  end;

  //Ищем по блокам единственные клетки
  OnlyOneCellInBlock(field, ri, rj, rv);
  if (ri <> 0) and (rj <> 0) and (rv <> 0) then
  begin
    VCL_field[ri, rj].Text := IntToStr(Ord(rv));
    VCL_field[ri, rj].Font.Color := clRed;
    Edit1Change(vcl_field[ri, rj]);
    Exit;
  end;

  //Ищем по строкам единственные возможные размещения
  OnlyOneCellInRow(field, ri, rj, rv);
  if (ri <> 0) and (rj <> 0) and (rv <> 0) then
  begin
    VCL_field[ri, rj].Text := IntToStr(Ord(rv));
    VCL_field[ri, rj].Font.Color := clRed;
    Edit1Change(vcl_field[ri, rj]);
    Exit;
  end;

  //Ищем по столбцам единственные возможные размещения
  OnlyOneCellInCol(field, ri, rj, rv);
  if (ri <> 0) and (rj <> 0) and (rv <> 0) then
  begin
    VCL_field[ri, rj].Text := IntToStr(Ord(rv));
    VCL_field[ri, rj].Font.Color := clRed;
    Edit1Change(vcl_field[ri, rj]);
    Exit;
  end;

  // Ищем двойки в секторах
  PairInBlock(field, fl);
  if fl then
  begin
    btnHelpClick(nil);
    Exit;
  end;

  // Ищем двойки в строках
  PairInRow(field, fl);
  if fl then
  begin
    btnHelpClick(nil);
    Exit;
  end;

  // Ищем двойки в столбцах
  PairInCol(field, fl);
  if fl then
  begin
    btnHelpClick(nil);
    Exit;
  end;

  // Ищем секретные двойки в секторах
  SecretPairInBlock(field, fl);
  if fl then
  begin
    btnHelpClick(nil);
    Exit;
  end;

  // Ищем секретные двойки в строках
  SecretPairInRow(field, fl);
  if fl then
  begin
    btnHelpClick(nil);
    Exit;
  end;

  // Ищем секретные двойки в столбцах
  SecretPairInCol(field, fl);
  if fl then
  begin
    btnHelpClick(nil);
    Exit;
  end;

  //
  AllValuesInBlockInOneRowOrCol(field, fl);
  if fl then
  begin
    btnHelpClick(nil);
    Exit;
  end;

  ShowMessage('Нет вариантов!');
end;

procedure TForm1.btnLoadClick(Sender: TObject);
var
  f: TextFile;
  i, j: Byte;
  c: char;
begin
  btn_new_fieldClick(nil);
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

procedure TForm1.btnpossible_valuesClick(Sender: TObject);
var
  i, j: Byte;
  e: TEVal;
  s: string;
begin
  for i := 1 to FIELD_SIZE do
    for j := 1 to FIELD_SIZE do
    begin
      s := '';
      for e := TEVal(1) to TEVal(9) do
        if e in field[i, j].possible_values then
          s := s + inttostr(ord(e));
      VCL_field[i, j].Hint := s;

    end;
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

        VCL_field[i, j].Hint := '';
        VCL_field[i, j].ShowHint := True;

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

