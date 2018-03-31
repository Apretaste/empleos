

<table cellspacing="0" cellpadding="10" border="0" width="100%">
    <tr>
        <td><h1>Mis ofertas de trabajo</h1></td>
        <td align="right">{button href="TRABAJOS AGREGAR" popup="true" caption="agregar" desc="t:T&iacute;tulo*" size="small"}</td>
    </tr>
    {foreach item=job from=$jobs}
    <tr {if $job@iteration is odd}style="background-color:#F2F2F2;"{/if}>
        <td>{$job->title}</td>
        <td align="right">{button size="small" color="grey" href="TRABAJOS TRABAJO {$job->id}" caption="editar"}</td>
    </tr>
    {/foreach}
</table>

<p align="center">
    {button href="TRABAJOS INICIO" caption="Inicio"} &nbsp;
    {button href="TRABAJOS RECLUTAR" caption="Buscar trabajador" popup="true" desc="t:Buscar"}
</p>

