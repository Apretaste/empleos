<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<style type="text/css">
			@media only screen and (max-width: 600px) {
				#container {
					width: 100%;
				}
			}
			@media only screen and (max-width: 480px) {
				.button {
					display: block !important;
				}
				.button a {
					display: block !important;
					font-size: 18px !important; width: 100% !important;
					max-width: 600px !important;
				}
				.section {
					width: 100%;
					margin: 2px 0px;
					display: block;
				}
				.phone-block {
					display: block;
				}
			}
			body{
				font-family: Arial;
			}
			h1{
				color: #C11414;
				text-transform: uppercase;
				font-size: 22px;
				font-weight: normal;
			}
			h2{
				color: #C11414;
				text-transform: uppercase;
				font-size: 16px;
				margin-top: 30px;
				font-weight: normal;
			}
			.background{
				background: white;
				padding: 10px;
			}
		</style>
	</head>
	<body leftmargin="0" marginwidth="0" topmargin="0" marginheight="0" offset="0" style="font-family: Arial;">
		<center>
			<table id="container" bgcolor="#F2F2F2" border="0" cellpadding="0" cellspacing="0" valign="top" align="center" width="600">
				<!--logo-->
				<tr>
					<td valign="middle" style="padding-left:25px;">
                        {link href="TRABAJOS" caption="<b>TRABAJOS</b>" style="color:#000000; font-size:40px; font-family:Times; text-decoration: none;"}
					</td>
					<!--notifications & profile-->
					<td align="right" class="emoji" valign="middle" style="padding:10px 25px 0px 0px;">
                        &nbsp;
                        {link href="TRABAJOS EDITAR" caption="👤" style="color:#9E100A; text-decoration: none;"}&nbsp;&nbsp;&nbsp;
                        {link href="CHAT" caption="💬" style="color:#9E100A; text-decoration: none;"}&nbsp;&nbsp;&nbsp;
                        {link href="TRABAJOS OFERTAS" caption="📜" style="color:#9E100A; text-decoration: none;"}&nbsp;&nbsp;
					</td>
				</tr>

				<!--main section-->
				<tr>
					<td style="padding: 5px 10px 0px 10px;" colspan="3">
						<div class="background">
							{include file="$APRETASTE_USER_TEMPLATE"}
						</div>
					</td>
				</tr>

				<!--footer-->
				<tr>
					<td align="center" bgcolor="#F2F2F2" style="padding: 20px 0px;">
						<small>{$smarty.now|date_format:"%Y"} &copy; Some Rights Reserved</small>
					</td>
				</tr>
			</table>
		</center>
	</body>
</html>
