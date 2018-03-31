<table width="100%">
    <tr>
        <td width="150">
            <!--PROFILE PICTURE-->
            {if $profile->picture}
                <table cellpadding="3"><tr><td bgcolor="#202020">
                            {img src="{$profile->picture_internal}" alt="Picture" width="200"}
                        </td></tr></table>
            {else}
                {noimage width="200" height="100" text="Tristemente ...<br/>Sin foto de perfil :'-("}
            {/if}
            {if $editMode}
            {button color="grey" href="PERFIL FOTO" desc="u:Adjunte su foto de perfil*" caption="Cambiar" size="small" wait="false" popup="true"}
            {/if}
        </td>
        <td valign="top" align="right">
            <h1>{if $cv->full_name}{$cv->full_name}{else}(tu nombre){/if} {if $editMode}{link href="TRABAJOS NOMBRE" caption="&#10000;" desc="Cambiar nombre" popup="true"}{/if}</h1><br/>
            {if $cv->profession1} {$cv->profession1_title} {else} (profesion #1) {/if} {if $editMode}{link href="TRABAJOS PROFESION 1" caption="&#10000;" popup="true" desc="m:Profesi&oacute;n[{$professions}]*"}{/if}
            {if $cv->profession2} {$cv->profession2_title} {else} (profesion #2) {/if} {if $editMode}{link href="TRABAJOS PROFESION 2" caption="&#10000;" popup="true" desc="m:Profesi&oacute;n[{$professions}]*"}{/if}
            {if $cv->profession3} {$cv->profession3_title} {else} (profesion #3) {/if} {if $editMode}{link href="TRABAJOS PROFESION 3" caption="&#10000;" popup="true" desc="m:Profesi&oacute;n[{$professions}]*"}{/if}
            <br/>
            {if $cv->province}{$cv->province}{else}(provincia){/if} {if $editMode}{link href="TRABAJOS PROVINCIA" popup="true" desc="Provincia" caption="&#10000;" desc="m:Provincia[{$provinces}]*"}<br/>{/if}
        </td>
    </tr>
    <tr>
        <td colspan="2" valign="top" align="justify">
            {if $cv->description}{$cv->description}{else}(breve descripci&oacute;n de ti){/if}
            {if $editMode}{link href="TRABAJOS DESCRIPCION" popup="true" caption="&#10000;" desc="a:Descripci&oacute;n (hasta 255 caracteres)"}{/if}
        </td>
    </tr>
</table>
{if $showStats}
{space10}
<p align="center">
    Fuerza de tu curr&iacute;culo: {$cv->force}% &nbsp; Tu CV ha sido visto {$cv->views} veces
</p>
{/if}
{space10}
<hr/>
<table width="100%">
    <tr>
        <td colspan="3"><h1>Educaci&oacute;n</h1></td>
        <td align="right">{if $editMode}{button color="green" size="small" caption="agregar" href="TRABAJOS EDUCACION" popup="true" desc="n:A&ntilde;o de graduaci&oacute;n*|t:T&iacute;tulo"}{/if}</td>
    </tr>
    {foreach item=item from=$cv->educations}
        <tr>
            <td>{$item->graduation_year} {if $editMode}{link href="TRABAJOS EDITAR EDUCACION {$item->id} GRADUACION" caption="&#10000;" popup="true" desc="n:A&ntilde;o de graduaci&oacute;n"}{/if}</td>
            <td>{if $item->title} {$item->title} {else} agregar t&iacute;tulo {/if} {if $editMode}{link href="TRABAJOS EDITAR EDUCACION {$item->id} TITULO" caption="&#10000;" popup="true" desc="t:T&iacute;tulo"}{/if}</td>
            <td>{if $item->school} {$item->school} {else} agregar escuela {/if} {if $editMode}{link href="TRABAJOS EDITAR EDUCACION {$item->id} ESCUELA" popup="true" desc="Escuela" caption="&#10000;"}{/if}</td>
            {if $editMode}<td align="right">{button size="small" color="grey" href="TRABAJOS QUITAR EDUCACION {$item->id}" caption="quitar"}</td>{/if}
        </tr>
    {/foreach}
</table>

{space10}
<hr/>
<table width="100%">
    <tr><td colspan="4"><h1>Experiencia</h1></td><td align="right">{if $editMode}{button size="small" color="green" caption="agregar" href="TRABAJOS EXPERIENCIA" popup="true" desc="n:A&ntilde;o de inicio*|t:Ocupaci&oacute;n"}{/if}</td></tr>
    {foreach item=item from=$cv->experiences}
        <tr>
            <td>{if $item->start_year}{$item->start_year}{else}(desde){/if} {if $editMode}{link href="TRABAJOS EDITAR EXPERIENCIA {$item->id} DESDE" caption="&#10000;" popup="true" desc="n:A&ntilde;o desde"}{/if}</td>
            <td>{if $item->end_year}{$item->end_year}{else}(hasta){/if} {if $editMode}{link href="TRABAJOS EDITAR EXPERIENCIA {$item->id} HASTA " caption="&#10000;" popup="true" desc="n:A&ntilde;o final"}{/if}</td>
            <td>{if $item->title}{$item->title}{else}(t&iacute;tulo){/if} {if $editMode}{link href="TRABAJOS EDITAR EXPERIENCIA {$item->id} TITULO " caption="&#10000;" popup="true" desc="T&iacute;tulo/Ocupaci&oacute;n/Cargo"}{/if}</td>
            <td>{if $item->company}{$item->company}{$item->company}{else}(compa&ntilde;&iacute;a){/if} {if $editMode}{link href="TRABAJOS EDITAR EXPERIENCIA {$item->id} COMPANIA " caption="&#10000;" popup="true" desc="Compa&ntilde;&iacute;a"}{/if}</td>
            <td align="right">{if $editMode}{button href="TRABAJOS QUITAR EXPERIENCIA {$item->id}" caption="quitar" color="grey" size="small"}{/if}</td>
        </tr>
    {/foreach}
</table>

{space10}
<hr/>
<table width="100%">
    <tr><td colspan="3"><h1>Habilidades</h1></td><td align="right">{if $editMode}{button color="green" caption="agregar" size="small" href="TRABAJOS HABILIDAD" popup="true" desc="Habilidad"}{/if}</td></tr>
    {foreach item=item from=$cv->skills}
        <tr><td colspan="3">{$item->skill}</td><td align="right">{if $editMode}{button size="small" color="grey" href="TRABAJOS QUITAR HABILIDAD {$item->id}" caption="quitar"}{/if}</td></tr>
    {/foreach}
</table>

{space10}
<hr/>
<table width="100%">
    <tr><td colspan="2"><h1>Idiomas</h1></td>
        <td align="right"> {if $editMode}{button size="small" color="green" caption="agregar" href="TRABAJOS IDIOMA" popup="true" desc="m:idioma[ESPA&Ntilde;OL,INGLES,FRANCES,ITALIANO,RUSO,CHINO,JAPONES]*|m:nivel[Nativo,Fluido,Conversacional,Escrito]*"}{/if}</td></tr>
    {foreach item=item from=$cv->langs}
    <tr><td>{$item->lang}</td><td>{$item->lang_level}</td>
        <td align="right"> {if $editMode}{button size="small" color="grey" href="TRABAJOS QUITAR IDIOMA {$item->id}" caption="quitar"}{/if}</td>
        {/foreach}
</table>

{space10}
<hr/>
<p align="center">
    {button href="TRABAJOS INICIO" caption="Inicio"} &nbsp;
    {if $employer == 1}
    {button href="TRABAJOS EDITAR" caption="Editar CV"}
    {button href="TRABAJOS BUSCAR" caption="Buscar trabajo" popup="true" desc="t:Buscar"}
    {/if}
    {if $employer == 2}
        {button href="TRABAJOS TRABAJADOR" caption="Buscar trabajador" popup="true" desc="t:Buscar"}
        {button href="TRABAJOS OFERTAS" caption="Mis ofertas"}
    {/if}
    {if !$showStats}
    {button href="CHAT @{$profile->username} Quisiera contactar contigo para asuntos de trabajo" caption="CONTACTAR"}
    {/if}
</p>
</center>