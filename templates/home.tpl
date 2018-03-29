<p align="center">
    Hola <br/>
    @{$username}
</p>

<table cellspacing="0" cellpadding="10" border="0" width="100%">
    <tr>
        <td>Fuerza de tu curr&iacute;culo
        <br/>{link href="TRABAJOS EDITAR" caption="editar tu curr&iacute;culo"}</td>
        <td>{$cv->force}%</td>
    </tr>
    <tr style="background-color:#F2F2F2;">
        <td>Veces que han revisado tu curr&iacute;culo</td>
        <td>{$cv->views}</td>
    </tr>
    <tr>
        <td>Mensajes recibidos
            <br/>{link href="CHAT" caption="ver mensajes"}</td>
        <td>{$cv->messages_count}</td>
    </tr>
    <tr style="background-color:#F2F2F2;">
        <td>Mis trabajos publicados
            <br/>{link href="TRABAJOS OFERTAS" caption="ver trabajos"}
            <br/>{link href="TRABAJOS AGREGAR" popup="true" caption="publicar trabajo" desc="t:T&iacute;tulo*"}</td>
        <td>{$cv->jobs}</td>
    </tr>
</table>
<p align="center">
{button href="TRABAJOS BUSCAR" caption="Buscar trabajo" popup="true" desc="t:Buscar"}
{button href="TRABAJOS RECLUTAR" caption="Buscar trabajador" popup="true" desc="t:Buscar"}
</p>
