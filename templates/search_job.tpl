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
    <tr><td colspan="3">No se encontraron trabajos asociados a su b&uacute;squeda.</td></tr>
{/foreach}
</table>
{space10}
<p align="center">
    {button size="medium" href="TRABAJOS" caption="Atr&aacute;s"}
    {button size="medium" href="TRABAJOS BUSCAR" caption="Buscar" popup="true" desc="t:Buscar por las palabras|m:Filtrar por profesi&oacute;n[{$professions}]|n:Salario m&iacute;nimo|m:Filtrar por tipo de contrato[PROYECTO,SALARIO]|m:Filtrar por nivel esperado[EXPERTO,AVANZADO,PRINCIPIANTE]"}
    {button size="medium" href="TRABAJOS PERFIL" caption="Mi perfil" }
</p>