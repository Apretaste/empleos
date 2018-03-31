<h1>Trabajadores</h1>
<table width="100%">
    {foreach item=cv from=$cvs}
        <tr>
            <td valign="top"> {img src="{$cv->profile->picture_internal}" alt="Picture" width="100"}</td>
            <td valign="top">
                <h3>{$cv->full_name}</h3>
                {$cv->province}<br/>
            {$cv->profession1_title}, {$cv->profession2_title}, {$cv->profession3_title}<br/>
            {$cv->experience_years} a&ntilde;os de experiencia</td>
            <td valign="bottom">{button color="grey" size="small" href="TRABAJOS PERFIL {$cv->profile->username}" caption="ver"}</td>
        </tr>
    {/foreach}
</table>

<p align="center">
    {button href="TRABAJOS INICIO" caption="Inicio"}
    {button href="TRABAJOS TRABAJADOR" caption="Buscar trabajador" popup="true" desc="t:Buscar"}
</p>
