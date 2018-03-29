<center>
    <!--PROFILE PICTURE-->
    {if $profile->picture}
        <table cellpadding="3"><tr><td bgcolor="#202020">
                    {img src="{$profile->picture_internal}" alt="Picture" width="300"}
                </td></tr></table>
    {else}
        {noimage width="300" height="200" text="Tristemente ...<br/>Sin foto de perfil :'-("}
    {/if}

        {$cv->full_name} <br/>

    {if $cv->profession1}
        {$cv->profession1_title}
    {/if}

    {if $cv->profession2}
        {$cv->profession2_title}
    {/if}

    {if $cv->profession3}
        {$cv->profession3_title}
    {/if}

    <br/>
    {$cv->province}<br/>
    {space10}

    <!--ABOUT ME-->
    <p align="center">{$cv->description}</p>

    {space10}

    <h2>Educaci&oacute;n</h2>

    {foreach item=item from=$cv->educations}
        {$item->graduation_year} -
        {if $item->title}
            {$item->title} -
        {/if}
        {if $item->school}
            {$item->school} -
        {/if}
        <br/>
    {/foreach}

    {space10}
    <h2>Experiencia</h2>

    {foreach item=item from=$cv->experiences}
        {$item->start_year} - {$item->end_year} <b>{$item->title}</b> {$item->company}<br/>
    {/foreach}

    {space10}
    <h2>Habilidades</h2>
    <p align="center">
        {foreach item=item from=$cv->skills}
            {$item->skill}
        {/foreach}
    </p>

    {space10}
    <h2>Idiomas</h2>
    {foreach item=item from=$cv->langs}
        <p align="center">{$item->lang}, {$item->lang_level}</p>
    {/foreach}

    {space10}
    <p align="center">
        {button href="TRABAJOS" caption="INICIO"}
        {button href="CHAT @{$profile->username} Quisiera contactar contigo para asuntos de trabajo" caption="CONTACTAR"}
    </p>
</center>