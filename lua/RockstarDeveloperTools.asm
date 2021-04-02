ENABLE:
    alloc(Devmode,$1000,IS_DLC_PRESENT)

    label(code)
    label(return)
    
    Devmode:
    
    code:
    mov [rsp+08],rbx
    
    IS_DLC_PRESENT:
    mov al,01
    ret
    and al,08
    return:
DISABLE:
    IS_DLC_PRESENT:
    mov [rsp+08],rbx
    push rdi
    dealloc(Devmode)