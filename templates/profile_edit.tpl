<table width="100%">
    <tr>
        <td>
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

            {link href="TRABAJOS NOMBRE" caption="{if $cv->full_name}{$cv->full_name}{else}[nombre]{/if}" desc="Cambiar nombre" popup="true"}<br/>

            {if $cv->profession1}
                {link href="TRABAJOS PROFESION 1" caption="{$cv->profession1_title}" popup="true" desc="m:Profesi&oacute;n[{$professions}]*"}
            {else}
                {button href="TRABAJOS PROFESION 1" caption="profesion #1" popup="true" desc="m:Profesi&oacute;n[{$professions}]*"}
            {/if}

            {if $cv->profession2}
                {link href="TRABAJOS PROFESION 2" caption="{$cv->profession2_title}" popup="true" desc="m:Profesi&oacute;n[{$professions}]*"}
            {else}
                {link href="TRABAJOS PROFESION 2" caption="profesion #2" popup="true" desc="m:Profesi&oacute;n[{$professions}]*"}
            {/if}

            {if $cv->profession3}
                {link href="TRABAJOS PROFESION 3" caption="{$cv->profession3_title}" popup="true" desc="m:Profesi&oacute;n[{$professions}]*"}
            {else}
                {link href="TRABAJOS PROFESION 3" caption="profesion #3" popup="true" desc="m:Profesi&oacute;n[{$professions}]*"}
            {/if}

            <br/>
            {link href="TRABAJOS PROVINCIA" popup="true" desc="Provincia" caption="{if $cv->province}{$cv->province}{else}[provincia]{/if}" desc="m:Provincia[{$provinces}]*"}<br/>

        </td>
    </tr>
</table>
{space10}

<!--ABOUT ME-->
<p align="center">{link href="TRABAJOS DESCRIPCION" popup="true" caption="{if $cv->description}{$cv->description}{else}[descripci&oacute;n]{/if}" desc="a:Descripci&oacute;n (hasta 255 caracteres)"}</p>

{space10}

<h1>Educaci&oacute;n</h1>

{foreach item=item from=$cv->educations}
    {link href="TRABAJOS EDITAR EDUCACION {$item->id} GRADUACION" caption="{$item->graduation_year}" popup="true" desc="n:A&ntilde;o de graduaci&oacute;n"} -
    {if $item->title} {$item->title} {else} agregar t&iacute;tulo {/?}
    {link href="TRABAJOS EDITAR EDUCACION {$item->id} TITULO" caption="&#x270F;" popup="true" desc="t:T&iacute;tulo"}

    {if $item->school}
        {link href="TRABAJOS EDITAR EDUCACION {$item->id} ESCUELA" popup="true" desc="Escuela" caption="{$item->school}"} -
        {else}
        {link href="TRABAJOS EDITAR EDUCACION {$item->id} ESCUELA {$item->school}" popup="true" caption="[escuela]"}
    {/if}

    {link href="TRABAJOS QUITAR EDUCACION {$item->id}" caption="x"}<br/>
{/foreach}

{button caption="Agregar" href="TRABAJOS EDUCACION" popup="true" desc="n:A&ntilde;o de graduaci&oacute;n*|t:T&iacute;tulo"}

{space10}
<h1>Experiencia</h1>
{link caption="+" href="TRABAJOS EXPERIENCIA" popup="true" desc="n:A&ntilde;o de inicio*|t:Ocupaci&oacute;n"}

{foreach item=item from=$cv->experiences}
    {link href="TRABAJOS EDITAR EXPERIENCIA {$item->id} DESDE" caption="{$item->start_year}" popup="true" desc="n:A&ntilde;o desde"} -

    {if $item->end_year}
        {link href="TRABAJOS EDITAR EXPERIENCIA {$item->id} HASTA " caption="{$item->end_year}" popup="true" desc="n:A&ntilde;o final"}
    {else}
        {link href="TRABAJOS EDITAR EXPERIENCIA {$item->id} HASTA" caption="hasta" popup="true" desc="n:A&ntilde;o final"}
    {/if}

    {link href="TRABAJOS EDITAR EXPERIENCIA {$item->id} TITULO " caption="{$item->title}" popup="true" desc="T&iacute;tulo/Ocupaci&oacute;n/Cargo"}

    {if $item->company}
        {link href="TRABAJOS EDITAR EXPERIENCIA {$item->id} COMPANIA " caption="{$item->company}" popup="true" desc="Compa&ntilde;&iacute;a"}
    {else}
        {link href="TRABAJOS EDITAR EXPERIENCIA {$item->id} COMPANIA " caption="[compa&ntilde;ia]" popup="true" desc="Compa&ntilde;&iacute;a/Empresa"}
    {/if}

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
<h2>Idiomas {link caption="+" href="TRABAJOS IDIOMA" popup="true" desc="m:idioma[ESPA&Ntilde;OL,INGLES,FRANCES,ITALIANO,RUSO,CHINO,JAPONES]*|m:nivel[Nativo,Fluido,Conversacional,Escrito]*"}</h2>
{foreach item=item from=$cv->langs}
    <p align="center">{$item->lang}, {$item->lang_level} {link href="TRABAJOS QUITAR IDIOMA {$item->id}" caption="x"}</p>
{/foreach}

{space10}
<p align="center">
    {button href="TRABAJOS" caption="INICIO"}
    {button href="CHAT @{$profile->username} Quisiera contactar contigo para asuntos de trabajo" caption="CONTACTAR"}
</p>
</center>