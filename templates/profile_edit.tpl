<center>
    <!--PROFILE PICTURE-->
    {if $profile->picture}
        <table cellpadding="3"><tr><td bgcolor="#202020">
                    {img src="{$profile->picture_internal}" alt="Picture" width="300"}
                </td></tr></table>
    {else}
        {noimage width="300" height="200" text="Tristemente ...<br/>Sin foto de perfil :'-("}
    {/if}

{if $cv->full_name}
    {$cv->full_name} {link href="TRABAJOS NOMBRE" caption="editar" desc="Cambiar nombre" popup="true"}<br/>
    {else}
    {link href="TRABAJOS NOMBRE" popup="true" desc="Nombre" caption="agregar nombre"}<br/>
{/if}

{if $cv->profession1}
    {link href="TRABAJOS PROFESSION 1" caption="{$cv->profession1}" popup="true" desc="m:Profesi&oacute;n[{$professions}]"}
    {else}
    {link href="TRABAJOS PROFESSION 1" caption="profesion #1" popup="true" desc="m:Profesi&oacute;n[{$professions}]"}
{/if}

{if $cv->profession2}
    {link href="TRABAJOS PROFESSION 2" caption="{$cv->profession2}" popup="true" desc="m:Profesi&oacute;n[{$professions}]"}
{else}
    {link href="TRABAJOS PROFESSION 2" caption="profesion #2" popup="true" desc="m:Profesi&oacute;n[{$professions}]"}
{/if}

{if $cv->profession2}
    {link href="TRABAJOS PROFESSION 3" caption="{$cv->profession3}" popup="true" desc="m:Profesi&oacute;n[{$professions}]"}
{else}
    {link href="TRABAJOS PROFESSION 3" caption="profesion #3" popup="true" desc="m:Profesi&oacute;n[{$professions}]"}
{/if}

{if $cv->province}
    {$cv->province} {link href="TRABAJOS PROVINCIA" popup="true" desc="Provincia" caption="editar"}<br/>
    {else}
    {link href="TRABAJOS PROVINCIA" popup="true" desc="Nombre" caption="agregar provincia"}<br/>
{/if}
{space10}

<!--ABOUT ME-->
<p align="center">{$cv->description}</p>

{space10}

<h2>Educaci&oacute;n {link caption="+" href="TRABAJOS EDUCACION" popup="true" desc="n:A&ntilde;o de graduaci&oacute;n*|t:Escuela/Universidad/Instituto"}</h2>

{foreach item=item from=$cv->educations}
    {$item->graduation_year} - {$item->school} {link href="TRABAJOS QUITAR EDUCACION {$item->id}" caption="x"}<br/>
{/foreach}

{space10}
<h2>Experiencia {link caption="+" href="TRABAJOS EXPERIENCIA" popup="true" desc="n:A&ntilde;o de inicio*|t:Ocupaci&oacute;n"}</h2>

{foreach item=item from=$cv->experiences}
    {$item->start_year} - {if $item->end_year}{link href="TRABAJOS EDITAR EXPERIENCIA {$item->id} HASTA " caption="{$item->end_year}" popup="true" desc="n:A&ntillde;o final"}
    {else}
    {link href="TRABAJOS EDITAR EXPERIENCIA {$item->id} HASTA" caption="hasta" popup="true" desc="n:A&ntillde;o final"}{/if} {link href="TRABAJOS EDITAR EXPERIENCIA {$item->id} TITULO " caption="{$item->title}" popup="true" desc="T&iacute;tulo/Ocupaci&oacute;n/Cargo"}, {$item->company}
    {link href="TRABAJOS QUITAR EXPERIENCIA {$item->id}" caption="x"}<br/>
{/foreach}

{space10}
<h2>Habilidades {link caption="+" href="TRABAJOS HABILIDAD" popup="true" desc="Habilidad"}</h2>
<p align="center">
{foreach item=item from=$cv->skills}
    {$item->skill} {link href="TRABAJOS QUITAR HABILIDAD {$item->id}" caption="x"} &nbsp;
{/foreach}
</p>

{space10}
<h2>Idiomas {link caption="+" href="TRABAJOS IDIOMA" popup="true" desc="t:idioma*|m:nivel[Nativo,Fluido,Conversacional,Escrito]*"}</h2>
{foreach item=item from=$cv->langs}
    <p align="center">{$item->lang}, {$item->lang_level} {link href="TRABAJOS QUITAR IDIOMA {$item->id}" caption="x"}</p>
{/foreach}

{space10}
<p align="center">
    {button href="TRABAJOS" caption="INICIO"}
    {button href="CHAT @{$profile->username} Quisiera contactar contigo para asuntos de trabajo" caption="CONTACTAR"}
</p>
</center>