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
    {$cv->full_name} {link href="TRABAJOS NOMBRE {$cv->full_name}" caption="editar" desc="Cambiar nombre" popup="true"}<br/>
    {else}
    {link href="TRABAJOS NOMBRE" popup="true" desc="Nombre" caption="agregar nombre"}<br/>
{/if}

{foreach from=$cv->professions item=item}
    {$item->profession} {link href="TRABAJOS PROFESSION {$item->profession}" popup="true" desc="Nombre de la profesion" caption="editar"}
{/foreach}
<br/>
{link href="TRABAJOS PROFESSION" popup="true" desc="Nombre de la profesion" caption="agregar profesi&oacute;n"}

{if $cv->province}
    {$cv->province} {link href="TRABAJOS PROVINCIA" popup="true" desc="Provincia" caption="editar"}<br/>
    {else}
    {link href="TRABAJOS PROVINCIA" popup="true" desc="Nombre" caption="agregar provincia"}<br/>
{/if}
{space10}

<!--ABOUT ME-->
<p align="center">{$cv->description}</p>

{space10}

<h2>Educaci&oacute;n {link caption="+" href="TRABAJOS EDUCACION" popup="true" desc="n:graduation_year*|t:school"}</h2>
<ul>
{foreach item=item from=$cv->educations}
    <li>{$item->graduation_year} {$item->school}</li>
{/foreach}
</ul>

{space10}
<h2>Experiencia {link caption="+" href="TRABAJOS EXPERIENCIA" popup="true" desc="n:start_year*|n:end_year|t:title*|t:company"}</h2>
<ul>
    {foreach item=item from=$cv->experiences}
        <li>{$item->start_year}-{$item->end_year} {$item->title}, {$item->company}</li>
    {/foreach}
</ul>

{space10}
<h2>Habilidades {link caption="+" href="TRABAJOS HABILIDAD" popup="true" desc="habilidad"}</h2>
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