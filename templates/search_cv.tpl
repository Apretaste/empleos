<h1>Trabajadores</h1>
<table width="100%">
    {foreach item=cv from=$cvs}
        <tr>
            <td> {img src="{$cv->profile->picture_internal}" alt="Picture" width="100"}</td>
            <td>{$cv->full_name} - {$cv->province}<br/>
            {$cv->profession1}, {$cv->profession2}, {$cv->profession3}<br/>
            {$cv->experience_years} a&ntilde;os de experiencia</td>
            <td>{link href="TRABAJOS PERFIL {$cv->profile->username}" caption="ver"}</td>
        </tr>
    {/foreach}
</table>

<p align="center">
    {button href="TRABAJOS" caption="INICIO"}
    {button href="TRABAJOS BUSCAR" caption="Buscar trabajo" popup="true" desc="t:Buscar"}
    {button href="TRABAJOS TRABAJADOR" caption="Buscar trabajador" popup="true" desc="t:Buscar"}
</p>
