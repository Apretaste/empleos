<table cellspacing="0" cellpadding="10" border="0" width="100%">
    <tr>
        <td><h1>Mis ofertas de trabajo</h1></td>
        <td></td>
        <td align="right">{button href="TRABAJOS AGREGAR" popup="true" caption="agregar" desc="t:T&iacute;tulo*|a:Detalles|t:Nombre|t:Tel&eacute;fono|m:Buscando profesional[{$professions}]|d:Fecha de cierre|n:Salario|m:Tipo de contrato[PROYECTO,SALARIO]|m:Nivel esperado[EXPERTO,AVANZADO,PRINCIPIANTE]" size="small"}</td>
    </tr>
    {foreach item=job from=$jobs}
    <tr {if $job@iteration is odd}style="background-color:#F2F2F2;"{/if}>
        <td>{$job->title}</td>
        <td width="40" align="right">{button size="small" color="blue" href="TRABAJOS TRABAJO {$job->id}" caption="editar"}</td>
        <td width="40" align="right">{button size="small" color="grey" href="TRABAJOS QUITAR OFERTA {$job->id}" caption="quitar"}</td>
    </tr>
    {/foreach}
</table>

<p align="center">
    {button size="medium" href="TRABAJOS INICIO" caption="Inicio"} &nbsp;
    {button size="medium" href="TRABAJOS RECLUTAR" caption="Buscar trabajador" popup="true" desc="t:Buscar"}
</p>

