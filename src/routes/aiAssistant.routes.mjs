import { Router } from 'express';
import * as helperMid from '#/middlewares/helper-mid.mjs';
import * as aiAssistantCtl from '#/controllers/aiAssistantCtl.mjs';
import { validateChatMessage, validatePagination } from '#/middlewares/aiAssistant.validators.mjs';

const router = Router();
router.use(helperMid.isUserLoggedIn);

router.post('/',
    validateChatMessage,
    helperMid.catchValidationError,
    aiAssistantCtl.chat
);

router.get('/history',
    validatePagination,
    helperMid.catchValidationError,
    aiAssistantCtl.getHistory
);

router.delete('/history',
    aiAssistantCtl.clearHistory
);

router.get('/suggestions',
    aiAssistantCtl.getSuggestions
);

export default router;
