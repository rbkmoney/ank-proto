include "base.thrift"
include "msgpack.thrift"

namespace java com.rbkmoney.questionary.manage
namespace erlang questionary_manager

// id анкеты
typedef base.ID QuestionaryID
// id владельца анкеты
typedef base.ID EntityID
// Информация в анкете
typedef map<string, msgpack.Value> QuestionaryData

exception QuestionaryNotFound {}

struct Questionary {
    1: required QuestionaryID     id
    2: required EntityID          entity_id
    3: required QuestionaryType   type
    4: required QuestionaryState  state
    5: required QuestionaryData   data
}

struct QuestionaryParams {
    1: required QuestionaryID   id
    2: required EntityID        entity_id
    3: required QuestionaryType type
    4: required QuestionaryData data
}

union QuestionaryState {
    1: QuestionaryCreated  created
    2: QuestionaryReview   review
    3: QuestionaryApproved approved
    4: QuestionaryDenied   denied
}

struct QuestionaryCreated {}
struct QuestionaryReview {}
struct QuestionaryApproved {}
struct QuestionaryDenied {}

enum QuestionaryType {
    individual_person
    legal_person
}

/**
* Сервис для создания/редактирования анкеты
**/
service QuestionaryManager {

    Questionary Create(1: QuestionaryParams params)

    Questionary Get(1: QuestionaryID id) throws (1: QuestionaryNotFound ex)

    Questionary ChangeState(1: QuestionaryID id, 2: QuestionaryState state)

}
