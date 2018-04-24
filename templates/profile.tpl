{if $step == 1}
    <p>Tu curr&iacute;culo vitae est&aacute; incompleto y te recomendamos empezar a llenarlo. Ahora escribe tu nombre real por el cual te identifican profesionalmente; te recomendamos que no uses apodos.</p>
{/if}

{if $step == 2}
    <p>Define al menos una profesi&oacute;n, generalmente la que m&aacute;s te identifica como profesional.</p>
{/if}

{if $step == 3}
    <p>Es importante especificar tu lugar de residencia, puede ser decisivo en la obtenci&oacute;n de un empleo.</p>
{/if}

{if $step == 4}
    <p>Escribe una breve descripci&oacute;n sobre ti.</p>
{/if}

{if $step == 5}
    <p>Describe un poco acerca de tu formaci&oacute;n y di al menos un lugar donde estudiaste.</p>
{/if}

{if $step == 6}
    <p>Describe ahora donde has trabajado, al menos un lugar con experiencia profesional aunque haya sido como voluntario o un servicio social.</p>
{/if}

{if $step == 7}
  <p>¿Tienes alguna habilidad? Di todo en lo que te destacas como profesional. Generalmente palabras claves que definen tu trabajo y que los empleadores esperan encontrar.</p>
{/if}

{if $step == 8}
    <p>Di los idiomas que hablas, por lo menos especifica tu idioma nativo.</p>
{/if}

<table width="100%">
    <tr>
        <td width="150" align="center">
            <!--PROFILE PICTURE-->
            {if $profile->picture}
                <table cellpadding="3"><tr><td bgcolor="#202020">
                            {img src="{$profile->picture_internal}" alt="Picture" width="200"}
                        </td></tr></table>
            {else}
                {noimage width="200" height="100" text="Tristemente ...<br/>Sin foto de perfil :'-("}
            {/if}

            {if $step >= 1}
            <h1>{if $cv->full_name}{$cv->full_name}{else}(tu nombre){/if} {if $editMode}{link href="TRABAJOS NOMBRE" caption="&#10000;" desc="Cambiar nombre" popup="true"}{/if}</h1><br/>
            {/if}

            {if $step >= 2}
                {if $cv->profession1} {$cv->profession1_title} {else} (profesion #1) {/if} {if $editMode}{link href="TRABAJOS PROFESION 1" caption="&#10000;" popup="true" desc="m:Profesi&oacute;n[{$professions}]*"}{/if}
                {if $cv->profession2} {$cv->profession2_title} {else} (profesion #2) {/if} {if $editMode}{link href="TRABAJOS PROFESION 2" caption="&#10000;" popup="true" desc="m:Profesi&oacute;n[{$professions}]*"}{/if}
                {if $cv->profession3} {$cv->profession3_title} {else} (profesion #3) {/if} {if $editMode}{link href="TRABAJOS PROFESION 3" caption="&#10000;" popup="true" desc="m:Profesi&oacute;n[{$professions}]*"}{/if}
            {/if}
            <br/>

            {if $step >= 3}
                <br/>
                {if $cv->province}{$cv->province}{else}(provincia){/if} {if $editMode}{link href="TRABAJOS PROVINCIA" popup="true" desc="Provincia" caption="&#10000;" desc="m:Provincia[{$provinces}]*"}<br/>{/if}
            {/if}
        </td>
    </tr>
    <tr>
        <td valign="top" align="center">
            {if $step >= 4}
                <br/>
                {if $cv->description}{$cv->description}{else}(breve descripci&oacute;n de ti){/if}
                {if $editMode}{link href="TRABAJOS DESCRIPCION" popup="true" caption="&#10000;" desc="a:Descripci&oacute;n (hasta 255 caracteres)"}{/if}
            {/if}
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
{if $step >= 5}
    <hr/>
    <table width="100%">
        <tr>
            <td colspan="3"><h2>Educaci&oacute;n</h2></td>
            <td align="right">{if $editMode}{button color="green" size="small" caption="agregar" href="TRABAJOS EDUCACION" popup="true" desc="n:A&ntilde;o de graduaci&oacute;n*|t:T&iacute;tulo|t:Escuela"}{/if}</td>
        </tr>
        {foreach item=item from=$cv->educations}
            <tr>
                <td>{$item->graduation_year} {* {if $editMode}{link href="TRABAJOS EDITAR EDUCACION {$item->id} GRADUACION" caption="&#10000;" popup="true" desc="n:A&ntilde;o de graduaci&oacute;n"}{/if} *}</td>
                <td>{if $item->title} {$item->title} {else} <small>(t&iacute;tulo)</small> {/if} {* {if $editMode}{link href="TRABAJOS EDITAR EDUCACION {$item->id} TITULO" caption="&#10000;" popup="true" desc="t:T&iacute;tulo"}{/if} *}</td>
                <td>{if $item->school} {$item->school} {else} <small>(escuela)</small> {/if}{* {if $editMode}{link href="TRABAJOS EDITAR EDUCACION {$item->id} ESCUELA" popup="true" desc="Escuela" caption="&#10000;"}{/if} *}</td>
                {if $editMode}<td align="right">{button size="small" color="grey" href="TRABAJOS QUITAR EDUCACION {$item->id}" caption="quitar"}</td>{/if}
            </tr>
        {/foreach}
    </table>
{/if}

{if $step >= 6}
    {space10}
    <hr/>
    <table width="100%">
        <tr><td colspan="4"><h2>Experiencia</h2></td>
            <td align="right">
                {if $editMode}{button size="small" color="green" caption="agregar" href="TRABAJOS EXPERIENCIA" popup="true" desc="n:Desde el a&ntilde;o*|n:Hasta el a&ntilde;o|t:Ocupaci&oacute;n|t:Compa&ntilde;&iacute;a o empresa"}{/if}</td></tr>
        {foreach item=item from=$cv->experiences}
            <tr>
                <td>{if $item->start_year}{$item->start_year}{else}(desde){/if} {* {if $editMode}{link href="TRABAJOS EDITAR EXPERIENCIA {$item->id} DESDE" caption="&#10000;" popup="true" desc="n:A&ntilde;o desde"}{/if} *}</td>
                <td>{if $item->end_year}{$item->end_year}{else}(hasta){/if} {* {if $editMode}{link href="TRABAJOS EDITAR EXPERIENCIA {$item->id} HASTA " caption="&#10000;" popup="true" desc="n:A&ntilde;o final"}{/if} *}</td>
                <td>{if $item->title}{$item->title}{else}(t&iacute;tulo){/if} {* {if $editMode}{link href="TRABAJOS EDITAR EXPERIENCIA {$item->id} TITULO " caption="&#10000;" popup="true" desc="T&iacute;tulo/Ocupaci&oacute;n/Cargo"}{/if} *}</td>
                <td>{if $item->company}{$item->company}{else}(compa&ntilde;&iacute;a){/if} {* {if $editMode}{link href="TRABAJOS EDITAR EXPERIENCIA {$item->id} COMPANIA " caption="&#10000;" popup="true" desc="Compa&ntilde;&iacute;a"}{/if} *}</td>
                <td align="right">{if $editMode}{button href="TRABAJOS QUITAR EXPERIENCIA {$item->id}" caption="quitar" color="grey" size="small"}{/if}</td>
            </tr>
        {/foreach}
    </table>
{/if}
{if $step >= 7}
    {space10}
    <hr/>
    <table width="100%">
        <tr><td colspan="3"><h2>Habilidades</h2></td><td align="right">{if $editMode}{button color="green" caption="agregar" size="small" href="TRABAJOS HABILIDAD" popup="true" desc="Habilidad"}{/if}</td></tr>
        {foreach item=item from=$cv->skills}
            <tr><td colspan="3">{$item->skill}</td><td align="right">{if $editMode}{button size="small" color="grey" href="TRABAJOS QUITAR HABILIDAD {$item->id}" caption="quitar"}{/if}</td></tr>
        {/foreach}
    </table>
{/if}
{if $step >= 8}
    {space10}
    <hr/>
    <table width="100%">
        <tr><td colspan="2"><h2>Idiomas</h2></td>
            <td align="right"> {if $editMode}{button size="small" color="green" caption="agregar" href="TRABAJOS IDIOMA" popup="true" desc="m:idioma[ESPANOL,INGLES,FRANCES,ITALIANO,RUSO,CHINO,JAPONES]|m:nivel[Nativo,Fluido,Conversacional,Escrito]"}{/if}</td></tr>
        {foreach item=item from=$cv->langs}
        <tr><td>{$item->lang}</td><td>{$item->lang_level}</td>
            <td align="right"> {if $editMode}{button size="small" color="grey" href="TRABAJOS QUITAR IDIOMA {$item->id}" caption="quitar"}{/if}</td>
            {/foreach}
    </table>
{/if}
{space10}
<hr/>
<p align="center">
    {if $editMode}
        {button size="medium" href="TRABAJOS" caption="Atr&aacute;s"} &nbsp;
        {else}
        {if $showStats}
            {button size="medium" href="TRABAJOS INICIO" caption="Inicio"} &nbsp;
            {else}
            {button size="medium" href="TRABAJOS" caption="Atr&aacute;s"} &nbsp;
        {/if}
    {/if}

    {if $employer == 1}
    {button size="medium" href="TRABAJOS EDITAR" caption="Editar CV"}
    {button size="medium" href="TRABAJOS BUSCAR" caption="Buscar trabajo" popup="true" desc="t:Buscar por las palabras|m:Filtrar por profesi&oacute;n[{$professions}]|n:Salario m&iacute;nimo|m:Filtrar por tipo de contrato[PROYECTO,SALARIO]|m:Filtrar por nivel esperado[EXPERTO,AVANZADO,PRINCIPIANTE]"}
    {/if}
    {if $employer == 2}
        {button size="medium" href="TRABAJOS TRABAJADOR" caption="Reclutar" popup="true" desc="t:Buscar"}
        {button size="medium" href="TRABAJOS OFERTAS" caption="Mis ofertas"}
    {/if}
    {if !$showStats}
    {button size="medium" href="CHAT @{$profile->username} Quisiera contactar contigo para asuntos de trabajo" caption="CONTACTAR"}
    {/if}
</p>
</center>