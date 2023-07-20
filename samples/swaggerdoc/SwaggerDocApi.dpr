program SwaggerDocApi;
{$APPTYPE GUI}

uses
  FastMM4,
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  MainFormU in 'MainFormU.pas' {MainForm},
  WebModuleMainU in 'WebModuleMainU.pas' {WebModule1: TWebModule},
  MyController1U in 'MyController1U.pas',
  MyController2U in 'MyController2U.pas',
  MVCFramework.Swagger.Commons in '..\..\sources\MVCFramework.Swagger.Commons.pas',
  AuthHandler in 'AuthHandler.pas',
  MVCFramework.Filters.Swagger in '..\..\sources\MVCFramework.Filters.Swagger.pas';

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
