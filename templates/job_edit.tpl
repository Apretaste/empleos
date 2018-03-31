<h1>{$job->title} {link href="TRABAJOS EDITAR OFERTA {$job->id} TITULO" caption="&#10000;" desc="t:T&iacute;tulo" popup="true"}</b></h1>
<p align="justify">
    {if $job->details}{$job->details}{else}[descripci&oacute;n]{/if}
    {if $owner}{link href="TRABAJOS EDITAR OFERTA {$job->id} DETALLES" caption="&#10000;" desc="a:Descripci&oacute;n" popup="true"}{/if}
</p>
<p align="left">
    <b>Buscando:</b>
    {if $job->looking_for_profession}{$job->looking}{else}[buscando profesional]{/if}
    {if $owner}{link href="TRABAJOS EDITAR OFERTA {$job->id} BUSCANDO" caption="&#10000;" popup="true" desc="m:Qu&eacute; profesional buscas?[{$professions}]"}{/if}
    {separator}
    {if $owner}{if $job->name}{$job->name}{else}(nombre){/if} {link href="TRABAJOS EDITAR OFERTA {$job->id} NOMBRE" caption="&#10000;" popup="true"}{/if}
    {separator}
    {if $owner}{if $job->phone}{$job->phone}{else}(tel&eacute;fono){/if}{link href="TRABAJOS EDITAR OFERTA {$job->id} TELEFONO" caption="&#10000;" popup="true"}{/if}
</p>

{space10}
<p align="center">
    {button href="TRABAJOS INICIO" caption="Inicio"}
    {if $employer == 1}
        {button href="TRABAJOS EDITAR" caption="Editar CV"}
        {button href="TRABAJOS BUSCAR" caption="Buscar trabajo" popup="true" desc="t:Buscar"}
    {/if}
    {if $employer == 2}
        {button href="TRABAJOS TRABAJADOR" caption="Buscar trabajador" popup="true" desc="t:Buscar"}
        {button href="TRABAJOS OFERTAS" caption="Mis ofertas"}
    {/if}
    {if !$owner}
    {button href="CHAT @{$job->username} Quisiera contactar contigo para asuntos de trabajo" caption="Contactar"}
    {/if}
</p>