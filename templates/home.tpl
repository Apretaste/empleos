<p>Hola</p>
@{$username}
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
    <tr>
        <td>Mis trabajos publicados
            <br/>{link href="TRABAJOS OFERTAS" caption="ver trabajos"}
            <br/>{link href="TRABAJOS AGREGAR" popup="true" caption="publicar trabajo" desc="title*|a:deatils|name|phone|looking_for_profession|d:end_date*|f:salary|m:contract[Proyecto,Salario]|m:job_level[Eperto,Avanzado,Principiante]"}</td>
        <td>{$cv->jobs}</td>
    </tr>
</table>

{button href="TRABAJOS BUSCAR" caption="Buscar trabajo"}
{button href="TRABAJOS TRABAJADOR" caption="Buscar trabajador"}
