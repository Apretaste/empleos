<h1>Hola <i>@{$username}</i></h1>

<table cellspacing="0" cellpadding="10" border="0" width="100%">
    <tr>
        <td align="center" valign="top">
            <font size="20">&#x1F4C4;</font><br/>
            <big>{$cv->force}%</big>
        <br/>{link href="TRABAJOS EDITAR" caption="Editar curr&iacute;culo"}
        </td>
        <td align="center" valign="top">
            <font size="20">&#x1F4DD;</font><br/>
            Tu CV ha sido visto {$cv->views} veces<br/>
        </td>
    </tr>
    <tr>
        <td align="center" valign="top">
            <font size="20">&#x1F4AC;</font><br/>

            <br/>{link href="CHAT" caption="{$cv->messages_count} mensajes"}</td>
        <td>
        <td>
            <font size="20">&#x1F4AC;</font><br/>
            {link href="TRABAJOS OFERTAS" caption="Mis trabajos publicados"}
            <br/>{link href="TRABAJOS AGREGAR" popup="true" caption="publicar trabajo" desc="t:T&iacute;tulo*"}</td>
        <td>{$cv->jobs}</td>
    </tr>
</table>
<p align="center">
{button href="TRABAJOS BUSCAR" caption="Buscar trabajo" popup="true" desc="t:Buscar"}
{button href="TRABAJOS RECLUTAR" caption="Buscar trabajador" popup="true" desc="t:Buscar"}
</p>
