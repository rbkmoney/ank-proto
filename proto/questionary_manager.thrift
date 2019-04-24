include "base.thrift"
include "questionary.thrift"

namespace java com.rbkmoney.questionary.manage
namespace erlang questionary_manager

// id анкеты
typedef base.ID QuestionaryID
// id владельца анкеты
typedef base.ID OwnerID

exception QuestionaryNotFound {}

exception QuestionaryNotValidException {}

struct Questionary {
    1: required QuestionaryID    id
    2: required OwnerID          owner_id
    3: required QuestionaryData  data
}

struct QuestionaryParams {
    1: required QuestionaryID    id
    2: required OwnerID          owner_id
    3: required QuestionaryData  data
}

/* Содержание анкеты */
union QuestionaryData {
    1: questionary.LegalEntity      legal_entity
    2: questionary.IndividualEntity individual_entity
}

/**
* Сервис для работы с анкетами
*/
service QuestionaryManager {

    Questionary Create(1: QuestionaryParams params)
        throws (
            1: QuestionaryNotFound ex1
            2: QuestionaryNotValidException ex2
        )

    Questionary Get(1: QuestionaryID id) throws (1: QuestionaryNotFound ex)

}
