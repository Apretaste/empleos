<h1>Trabajos disponibles</h1>
{foreach item=job from=$jobs}
    {$job->salary} - Cierra en {$job->days} d&iacute;as - {$job->looking_for_profession} {$job->job_level}<br/>
    {link href="TRABAJOS TRABAJO {$job->id}" caption="{$job->title}"}<br/>
{/foreach}

<p align="center">
    {button href="TRABAJOS" caption="INICIO"}
    {button href="TRABAJOS BUSCAR" caption="Buscar trabajo" popup="true" desc="t:Buscar"}
    {button href="TRABAJOS RECLUTAR" caption="Buscar trabajador" popup="true" desc="t:Buscar"}
</p>