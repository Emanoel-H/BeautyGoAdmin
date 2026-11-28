unit uGeocodingService;

interface
uses
  System.Net.HttpClient, System.JSON, System.NetEncoding, System.StrUtils, System.SysUtils;
type
  TCoordenada = record
    Latitude, Longitude: Double;
  end;
type
  TGeocodingService = class
    private

    public
      function getEndereco(dLat, dLng: double): string;
      function Geocodificar(sEndereco: string): TCoordenada;
  end;

implementation

{ TGeocodingService }

function TGeocodingService.Geocodificar(sEndereco: string): TCoordenada;
var
  Http: THttpClient;
  Response: IHTTPResponse;
  JSON: TJSONArray;
  sURL: string;
begin
  if Trim(sEndereco) = '' then
    raise Exception.Create('Digite um endereço para localizar.');

  Http := THTTPClient.Create;
  try
    try
      Http.CustomHeaders['User-Agent'] := 'BeautyGoAdmin/1.0';

      sUrl := 'https://nominatim.openstreetmap.org/search?format=json&limit=1&q=' +
              TNetEncoding.URL.Encode(Trim(sEndereco));

      Response := Http.Get(sURL);
      if Response.StatusCode <> 200 then
        raise Exception.CreateFmt('Serviço de localização indisponível (HTTP %d)', [Response.StatusCode]);

      JSON := TJSONObject.ParseJSONValue(Response.ContentAsString()) as TJSONArray;
      try
        if (JSON <> nil) and (JSON.Count > 0) then
          raise Exception.Create('Endereço não encontrado. Tente ser mais específico.');

        Result.Latitude  := StrToFloat(JSON.Items[0].GetValue<string>('lat'), TFormatSettings.Invariant);
        Result.Longitude := StrToFloat(JSON.Items[0].GetValue<string>('lon'), TFormatSettings.Invariant);
      finally
        JSON.Free
      end;
    except
      on E: Exception do
      begin
        raise Exception.Create(PChar('Erro ao buscar localização: ' + E.Message));
      end;
    end;
  finally
    Http.Free;
  end;
end;

function TGeocodingService.getEndereco(dLat, dLng: double): string;
var
  Http: THttpClient;
  Response: IHTTPResponse;
  JSON: TJSONObject;
  sURL, sEndereco: string;
begin
  Http := THTTPClient.Create;
  try
    try
      Http.CustomHeaders['User-Agent'] := 'BeautyGoAdmin/1.0';

      sUrl := 'https://nominatim.openstreetmap.org/reverse?&format=json'+
              '&lat='+FloatToStr(dLat, TFormatSettings.Invariant)+
              '&lon='+FloatToStr(dLng, TFormatSettings.Invariant);

      Response := Http.Get(sURL);

      if Response.StatusCode <> 200 then
        Exit;

      JSON := TJSONObject.ParseJSONValue(Response.ContentAsString()) as TJSONObject;
      try
        if (JSON <> nil) and (JSON.Count > 0) then
        begin
          if not JSON.TryGetValue<string>('display_name', sEndereco) then
            sEndereco := '';
        end
        else
          raise Exception.Create('Endereço não encontrado conforme as coordenadas.');
      finally
        JSON.Free;
      end;
    except
      on E: Exception do
      begin
        raise Exception.Create(PChar('Erro ao buscar endereço: ' + E.Message));
      end;
    end;
  finally
    Result := sEndereco;
    Http.Free;
  end;
end;

end.
