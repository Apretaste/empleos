<table width="100%">
    <tr>
        <td width="150">
            <!--PROFILE PICTURE-->
            {if $profile->picture}
                <table cellpadding="3"><tr><td bgcolor="#202020">
                {img src="{$profile->picture_internal}" alt="Picture" width="150"}
                </td></tr></table>
            {else}
                {noimage width="150" height="75" text="Tristemente ...<br/>Sin foto de perfil :'-("}
            {/if}
        </td>
        <td>

            {if $cv->full_name}{$cv->full_name}{else}(tu nombre){/if} {link href="TRABAJOS NOMBRE" caption="&#10000;" desc="Cambiar nombre" popup="true"}<br/>

            {if $cv->profession1} {$cv->profession1_title} {else} (profesion #1) {/if} {link href="TRABAJOS PROFESION 1" caption="&#10000;" popup="true" desc="m:Profesi&oacute;n[{$professions}]*"}
            {if $cv->profession2} {$cv->profession2_title} {else} (profesion #2) {/if} {link href="TRABAJOS PROFESION 2" caption="&#10000;" popup="true" desc="m:Profesi&oacute;n[{$professions}]*"}
            {if $cv->profession3} {$cv->profession3_title} {else} (profesion #3) {/if} {link href="TRABAJOS PROFESION 3" caption="&#10000;" popup="true" desc="m:Profesi&oacute;n[{$professions}]*"}

            <br/>
            {if $cv->province}{$cv->province}{else}(provincia){/if} {link href="TRABAJOS PROVINCIA" popup="true" desc="Provincia" caption="&#10000;" desc="m:Provincia[{$provinces}]*"}<br/>

        </td>
    </tr>
</table>
{space10}

<!--ABOUT ME-->
<p align="center">{if $cv->description}{$cv->description}{else}(breve descripci&oacute;n de ti){/if}
{link href="TRABAJOS DESCRIPCION" popup="true" caption="&#10000;" desc="a:Descripci&oacute;n (hasta 255 caracteres)"}</p>

{space10}
<hr/>
<table width="100%">
<tr>
    <td colspan="3"><h1>Educaci&oacute;n</h1></td>
    <td align="right"><h1>{button color="green" size="small" caption="agregar" href="TRABAJOS EDUCACION" popup="true" desc="n:A&ntilde;o de graduaci&oacute;n*|t:T&iacute;tulo"}</h1></td>
</tr>
    {foreach item=item from=$cv->educations}
    <tr>
        <td>{$item->graduation_year} {link href="TRABAJOS EDITAR EDUCACION {$item->id} GRADUACION" caption="&#10000;" popup="true" desc="n:A&ntilde;o de graduaci&oacute;n"}</td>
        <td>{if $item->title} {$item->title} {else} agregar t&iacute;tulo {/if} {link href="TRABAJOS EDITAR EDUCACION {$item->id} TITULO" caption="&#10000;" popup="true" desc="t:T&iacute;tulo"}</td>
        <td>{if $item->school} {$item->school} {else} agregar escuela {/if} {link href="TRABAJOS EDITAR EDUCACION {$item->id} ESCUELA" popup="true" desc="Escuela" caption="&#10000;"}</td>
        <td align="right">{button size="small" color="grey" href="TRABAJOS QUITAR EDUCACION {$item->id}" caption="quitar"}</td>
    </tr>
{/foreach}
</table>

{space10}
<hr/>
<table width="100%">
    <tr><td colspan="4"><h1>Experiencia</h1></td><td align="right">{button size="small" color="green" caption="agregar" href="TRABAJOS EXPERIENCIA" popup="true" desc="n:A&ntilde;o de inicio*|t:Ocupaci&oacute;n"}</td></tr>
    {foreach item=item from=$cv->experiences}
    <tr>
        <td>{if $item->start_year}{$item->start_year}{else}(desde){/if} {link href="TRABAJOS EDITAR EXPERIENCIA {$item->id} DESDE" caption="&#10000;" popup="true" desc="n:A&ntilde;o desde"}</td>
        <td>{if $item->end_year}{$item->end_year}{else}(hasta){/if} {link href="TRABAJOS EDITAR EXPERIENCIA {$item->id} HASTA " caption="&#10000;" popup="true" desc="n:A&ntilde;o final"}</td>
        <td>{if $item->title}{$item->title}{else}(t&iacute;tulo){/if} {link href="TRABAJOS EDITAR EXPERIENCIA {$item->id} TITULO " caption="&#10000;" popup="true" desc="T&iacute;tulo/Ocupaci&oacute;n/Cargo"}
        <td>{if $item->company}{$item->company}{$item->company}{else}(compa&ntilde;&iacute;a){/if} {link href="TRABAJOS EDITAR EXPERIENCIA {$item->id} COMPANIA " caption="&#10000;" popup="true" desc="Compa&ntilde;&iacute;a"}</td>
        <td align="right">{button href="TRABAJOS QUITAR EXPERIENCIA {$item->id}" caption="quitar" color="grey" size="small"}</td>
    </tr>
    {/foreach}
</table>

{space10}
<hr/>
<table width="100%">
    <tr><td colspan="3"><h1>Habilidades</h1></td><td align="right">{button color="green" caption="agregar" size="small" href="TRABAJOS HABILIDAD" popup="true" desc="Habilidad"}</td></tr>
    {foreach item=item from=$cv->skills}
    <tr><td colspan="3">{$item->skill}</td><td align="right"> {button size="small" color="grey" href="TRABAJOS QUITAR HABILIDAD {$item->id}" caption="quitar"}</td></tr>
    {/foreach}
</table>

{space10}
<hr/>
<table width="100%">
    <tr><td colspan="2"><h1>Idiomas</h1></td>
        <td align="right"> {button size="small" color="green" caption="agregar" href="TRABAJOS IDIOMA" popup="true" desc="m:idioma[ESPA&Ntilde;OL,INGLES,FRANCES,ITALIANO,RUSO,CHINO,JAPONES]*|m:nivel[Nativo,Fluido,Conversacional,Escrito]*"}</td></tr>
    {foreach item=item from=$cv->langs}
    <tr><td>{$item->lang}</td><td>{$item->lang_level}</td>
        <td align="right"> {button size="small" color="grey" href="TRABAJOS QUITAR IDIOMA {$item->id}" caption="quitar"}</td>
    {/foreach}
</table>

{space10}
<hr/>
<p align="center">
    {button href="TRABAJOS" caption="INICIO"}
    {button href="CHAT @{$profile->username} Quisiera contactar contigo para asuntos de trabajo" caption="CONTACTAR"}
</p>
</center>