/// Из /obj/item/clothing/head/mob_holde/human/proc/Deposit() : (mob/living/carbon/human, obj/item/storage/backpack)
#define COMSIG_HUMAN_ENTER_STORAGE "human_enter_storage"
/// Из /obj/item/clothing/head/mob_holde/human/proc/Release() : (mob/living/carbon/human, obj/item/storage/backpack)
#define COMSIG_HUMAN_EXIT_STORAGE "human_exit_storage"
/// SSRealistic_physics : (atom/target, datum/reality_processing)
#define COMSIG_ATOM_TRY_REALITY_PROCESS "atom_reality_process"
	#define COMSIG_ATOM_REALITY_PROCESS_BLOCK (1 << 0)
