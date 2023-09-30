GLOBAL_VAR_INIT(world_reality_level, 2.33)

//Механика реальности - не обрабатывается, пока уровнь реальности не будет как-либо изменён.
#define REALITY_NO_PROCESS "r_no_process"
//Механика реальности будет обрабатываться постоянно, при любых условиях. Используется только для карбонов и их наследников.
#define REALITY_ALLWAYS_PROCESS "r_allways_process"
//Механика реальности обрабатывается только до момента приведения к глобальному уровню реальности.
#define REALITY_STABILAZE_PROCESS "r_stabilaze_process"

//Шаги изменения реальности за тик.
#define REALITY_STEP_CHANGE_SLOW 0.010
#define REALITY_STEP_CHANGE_NORMAL 0.20
#define REALITY_STEP_CHANGE_FAST 0.25
#define REALITY_STEP_CHANGE_ANOMALIST 0.33 //Аномалисты куда более устойчивы к изменеиям реальности вокруг них.

//Флаги защиты от изменений реальности.

#define REALITY_PROTECTION_IGNORE 0 < 1
#define REALITY_PROTECTION_ADAPTIVE 0 < 2
#define REALITY_PROTECTION_PROGRESSIVE 0 < 3

//Волшебные числа.

#define REALITY_LEVEL_NORMAL 2.33
#define REALITY_LEVEL_HAVOC 1.8
#define REALITY_LEVEL_LOSE 1
#define REALITY_LEVEL_BANISH 0.15
