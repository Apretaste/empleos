<h1>Trabajos disponibles</h1>
<table width="100%">
    <tr><th align="left">Trabajo</th><th align="left">Se busca</th><th></th></tr>
{foreach item=job from=$jobs}
    <tr>
        <td>{$job->title}</td>
        <td>{$job->looking_for}</td>
        <td align="right">{button color="grey" size="small" href="TRABAJOS TRABAJO {$job->id}" caption="ver"}</td>
    </tr>
    {foreachelse}
    <p>No se encontraron trabajos asociados a su b&uacute;squeda.</p>
{/foreach}
</table>
{space10}
<p align="center">
    {button size="small" href="TRABAJOS" caption="Atr&aacute;s"}
    {button size="small" href="TRABAJOS BUSCAR" caption="Empleos" popup="true" desc="t:Buscar empleo"}
    {button size="small" href="TRABAJOS PERFIL" caption="Mi perfil" }
</p>