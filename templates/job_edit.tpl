<h1 align="center">Oferta de empleo</h1>

<p align="center">
    <b>{link href="TRABAJOS EDITAR OFERTA {$job->id} TITULO" caption="{$job->title}" desc="t:T&iacute;tulo" popup="true"}</b><br/>
    {link href="TRABAJOS EDITAR OFERTA {$job->id} DETALLES" caption="{if $job->details}{$job->details}{else}[descripci&oacute;n]{/if}" desc="a:Descripci&oacute;n" popup="true"}
</p>

<h2 align="center">Detalles</h2>
<p align="center">
    <b>Se busca:</b>
    {link href="TRABAJOS EDITAR OFERTA {$job->id} BUSCANDO" caption="{if $job->looking_for_profession}{$job->looking}{else}[buscando profesional]{/if}" popup="true" desc="m:Qu&eacute; profesional buscas?[{$professions}]"}<br/>
</p>

<h2 align="center">Contacto</h2>
<p align="center">
    {link href="TRABAJOS EDITAR OFERTA {$job->id} NAME" caption="{if $job->name}{$job->name}{else}[nombre]{/if}" popup="true"}
    {link href="TRABAJOS EDITAR OFERTA {$job->id} TELEFONO" caption="{if $job->name}{$job->phone}{else}[tel&eacute;fono]{/if}" popup="true"}
</p>

{space10}
<p align="center">
    {button href="TRABAJOS" caption="INICIO"}
    {button href="CHAT @{$job->username} Quisiera contactar contigo para asuntos de trabajo" caption="CONTACTAR"}
</p>