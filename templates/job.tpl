<h1>{$job->title} {if $owner}{link href="TRABAJOS EDITAR OFERTA {$job->id} TITULO" caption="&#10000;" desc="t:T&iacute;tulo" popup="true"}{/if}</b></h1>
<p align="justify">
    {if $job->details}{$job->details}{else}[descripci&oacute;n]{/if}
    {if $owner}{link href="TRABAJOS EDITAR OFERTA {$job->id} DETALLES" caption="&#10000;" desc="a:Descripci&oacute;n" popup="true"}{/if}
</p>
<p align="left">
    <b>Buscando:</b>
    {if $job->looking_for_profession}{$job->looking}{else}(buscando profesional){/if}
    {if $owner}{link href="TRABAJOS EDITAR OFERTA {$job->id} BUSCANDO" caption="&#10000;" popup="true" desc="m:Qu&eacute; profesional buscas?[{$professions}]"}{/if}
    {separator}
   {if $job->name}{$job->name}{else}(nombre){/if}  {if $owner}{link href="TRABAJOS EDITAR OFERTA {$job->id} NOMBRE" caption="&#10000;" popup="true"}{/if}
    {separator}
    {if $job->phone}{$job->phone}{else}(tel&eacute;fono){/if} {if $owner}{link href="TRABAJOS EDITAR OFERTA {$job->id} TELEFONO" caption="&#10000;" popup="true"}{/if}
</p>

{space10}
<p align="center">
    {button size="small" href="TRABAJOS" caption="Atra&aacute;s"}
    {if $employer == 1}
        {button size="small" href="TRABAJOS EDITAR" caption="Editar CV"}
        {button size="small" href="TRABAJOS BUSCAR" caption="Buscar trabajo" popup="true" desc="t:Buscar"}
    {/if}
    {if $employer == 2}
        {button size="small" href="TRABAJOS TRABAJADOR" caption="Buscar trabajador" popup="true" desc="t:Buscar"}
        {button size="small" href="TRABAJOS OFERTAS" caption="Mis ofertas"}
    {/if}
    {if !$owner}
        {button size="small" href="CHAT @{$job->username} Quisiera contactar contigo para asuntos de trabajo" caption="Contactar"}
    {/if}
</p>