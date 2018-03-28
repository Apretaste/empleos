<h1>{$job->title}</h1>
{link href="TRABAJOS EDITAR OFERTA {$job->id} TITULO" caption="editar" desc="t:T&iacute;tulo" popup="true"}

<p align="center">
    {if $job->details}
        {link href="TRABAJOS EDITAR OFERTA {$job->id} DESCRIPCION" caption="{$job->details}" desc="a:Descripci&oacute;n" popup="true"}
        {else}
        {link href="TRABAJOS EDITAR OFERTA {$job->id} DESCRIPCION" caption="[descripci&oacute;n]" desc="a:Descripci&oacute;n" popup="true"}
    {/if}
</p>

<p>
{if $job->name}
    {link href="TRABAJOS EDITAR OFERTA {$job->id} NAME" caption="{$job->name}" popup="true"}
    {else}
    {link href="TRABAJOS EDITAR OFERTA {$job->id} NAME" caption="[nombre]" popup="true"}
{/if}
</p>

