unit uGeocodingService;

interface
uses
  System.Net.HttpClient, System.JSON, System.NetEncoding, System.StrUtils, System.SysUtils;
type
  TGeocodingService = class
    private

    public
      function getEndereco(dLat, dLng: double): string;
  end;


implementation

{ TGeocodingService }

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
